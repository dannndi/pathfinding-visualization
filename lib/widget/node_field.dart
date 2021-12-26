import 'package:flutter/material.dart';
import 'package:path_finder/model/node.dart';
import 'package:path_finder/utils.dart';

class NodeField extends StatelessWidget {
  const NodeField({
    Key? key,
    required this.node,
  }) : super(key: key);

  final Node node;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: (MediaQuery.of(context).size.width - 34) / 15,
      height: (MediaQuery.of(context).size.width - 34) / 15,
      decoration: BoxDecoration(
        color: node.isStart
            ? Utils.startColor
            : node.isFinish
                ? Utils.endColor
                : node.isShortes
                    ? Utils.shortColor
                    : node.isWall
                        ? Utils.wallColor
                        : node.isVisited
                            ? Utils.visitedColor
                            : Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
    );
  }
}
