import 'package:flutter/material.dart';
import 'package:path_finder/utils.dart';

class Hint extends StatelessWidget {
  Hint({
    Key? key,
    this.color = Colors.white,
    this.text = "",
  }) : super(key: key);

  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 52) / 3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 34) / 20,
            height: (MediaQuery.of(context).size.width - 34) / 20,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: color,
              border: (color == Colors.white)
                  ? Border.all(color: Colors.black)
                  : null,
            ),
          ),
          Text(
            text,
            style: Utils.bodyStyle.copyWith(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
