import 'package:flutter/material.dart';

class CLText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final int maxLines;

  CLText({Key key, @required this.text, this.fontSize, this.textColor, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
         color: textColor,
         ),
      maxLines: this.maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}