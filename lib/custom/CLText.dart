import 'package:flutter/material.dart';

class CLText extends StatelessWidget {

  final String text;
  final int maxLines = 1;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final TextOverflow overflow;

  CLText({
    Key key,
    @required this.text, 
    int maxLines, 
    this.textAlign,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
    this.style}):super(key:key);

  @override
  Text build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }
}
TextStyle setTextStyle({Color textColor, double fontSize, bool fontWeight}) {
      return TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight == true ? FontWeight.bold :FontWeight.normal,
      );
}