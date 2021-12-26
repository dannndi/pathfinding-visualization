import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path_finder/algoritm/dijkstra.dart';
import 'package:path_finder/model/node.dart';
import 'package:path_finder/utils.dart';

enum ClickState {
  start,
  finish,
  wall,
}

class PathFinderProvider extends ChangeNotifier {
  ClickState _currentState = ClickState.start;

  String get currentState {
    var value = "";
    if (_currentState == ClickState.start) {
      value = "Starting Point";
    } else if (_currentState == ClickState.finish) {
      value = "End Point";
    } else {
      value = "Walls / Barrier";
    }

    return value;
  }

  List<List<Node>> gridNodes = [];
  Node? startNode;
  Node? finishNode;
  bool isVisualized = false;

  PathFinderProvider() {
    _createGrid();
  }

  void _createGrid() {
    for (var col = 0; col < 15; col++) {
      List<Node> currentRow = [];
      for (var row = 0; row < 15; row++) {
        currentRow.add(Node(col: col, row: row));
      }
      gridNodes.add(currentRow);
    }
  }

  void clearGrid() {
    for (var element in gridNodes) {
      for (var item in element) {
        item.isStart = false;
        item.isFinish = false;
        item.isWall = false;
        item.isShortes = false;
        item.isVisited = false;
        item.distance = Utils.maxValue;
        item.previousNode = null;
      }
    }

    startNode = null;
    finishNode = null;
    isVisualized = false;
    _currentState = ClickState.start;
    notifyListeners();
  }

  void changeClickState(ClickState value) {
    if (isVisualized) return;
    _currentState = value;
    notifyListeners();
  }

  void onNodeTapped(Node node) {
    if (isVisualized) return;
    switch (_currentState) {
      case ClickState.start:
        // in case if choose node that already have state (wall / start / finish)
        // then do nothing
        if (node.isWall) return;
        if (node.isStart) return;
        if (node.isFinish) return;

        // in case that already set start node
        // then delete previous starting node
        if (startNode != null) {
          gridNodes[startNode!.col][startNode!.row] = startNode!.copyWith(
            isStart: false,
          );
        }
        // overwrite current node in [gridNodes]
        // with new state [!node.isStart]
        var isStart = !node.isStart;
        gridNodes[node.col][node.row] = node.copyWith(
          isStart: isStart,
        );
        startNode = isStart ? node : null;
        break;
      case ClickState.finish:
        // in case if choose node that already have state (wall / start / finish)
        // then do nothing
        if (node.isWall) return;
        if (node.isStart) return;
        if (node.isFinish) return;

        // in case that already set finish node
        // then delete previous starting node
        if (finishNode != null) {
          gridNodes[finishNode!.col][finishNode!.row] = finishNode!.copyWith(
            isFinish: false,
          );
        }

        // overwrite current node in [gridNodes]
        // with new state [!node.isFinish]
        var isFinish = !node.isFinish;
        gridNodes[node.col][node.row] = node.copyWith(
          isFinish: isFinish,
        );
        finishNode = isFinish ? node : null;
        break;
      case ClickState.wall:
        // in case if choose node that already have state (start / finish)
        // then do nothing
        if (node.isStart) return;
        if (node.isFinish) return;

        var isWall = !node.isWall;
        gridNodes[node.col][node.row] = node.copyWith(
          isWall: isWall,
        );
        break;
    }
    notifyListeners();
  }

  void startFindingPath() async {
    if (isVisualized) return;
    if (startNode == null || finishNode == null) return;
    // set visualize to true so user
    // can't start another visualization when already visualized
    isVisualized = true;

    var tempGrid = deepCopy(gridNodes);

    List<Node> visitedNodesInOrder = dijkstra(
      grid: tempGrid,
      startNode: tempGrid[startNode!.col][startNode!.row],
      finishNode: tempGrid[finishNode!.col][finishNode!.row],
    );

    List<Node> nodesInShortestPathOrder = getNodesInShortesPath(
      finishNode: tempGrid[finishNode!.col][finishNode!.row],
    );

    for (var i = 0; i <= visitedNodesInOrder.length; i++) {
      // if already animate all visited Nodes
      // then animate the shortest path
      if (i == visitedNodesInOrder.length) {
        for (var j = 0; j < nodesInShortestPathOrder.length; j++) {
          // delay every animation
          await Future.delayed(const Duration(milliseconds: 25));
          var node = nodesInShortestPathOrder[j];
          gridNodes[node.col][node.row] = node.copyWith(
            isShortes: true,
          );
          notifyListeners();
        }
        return;
      }
      // delay every animation
      await Future.delayed(const Duration(milliseconds: 25));
      var node = visitedNodesInOrder[i];
      gridNodes[node.col][node.row] = node;
      notifyListeners();
    }
  }

  List<List<Node>> deepCopy(List<List<Node>> gridNodes) {
    List<List<Node>> copy = [];
    for (var row in gridNodes) {
      List<Node> copyRow = [];
      for (var node in row) {
        copyRow.add(
          Node(
            col: node.col,
            row: node.row,
            isStart: node.isStart,
            isFinish: node.isFinish,
            isWall: node.isWall,
            isShortes: node.isShortes,
            isVisited: node.isVisited,
            distance: node.distance,
            previousNode: node.previousNode,
          ),
        );
      }
      copy.add(copyRow);
    }
    return copy;
  }
}
