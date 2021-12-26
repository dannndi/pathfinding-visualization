import 'package:path_finder/utils.dart';

class Node {
  int col;
  int row;
  bool isStart;
  bool isFinish;
  bool isWall;
  bool isShortes;
  bool isVisited;
  int distance;
  Node? previousNode;

  Node({
    required this.col,
    required this.row,
    this.isStart = false,
    this.isFinish = false,
    this.isWall = false,
    this.isShortes = false,
    this.isVisited = false,
    this.distance = Utils.maxValue,
    this.previousNode,
  });

  Node copyWith({
    int? col,
    int? row,
    bool? isStart,
    bool? isFinish,
    bool? isWall,
    bool? isShortes,
  }) {
    return Node(
      col: col ?? this.col,
      row: row ?? this.row,
      isStart: isStart ?? this.isStart,
      isFinish: isFinish ?? this.isFinish,
      isWall: isWall ?? this.isWall,
      isShortes: isShortes ?? this.isShortes,
    );
  }
}
