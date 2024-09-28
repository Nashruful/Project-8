import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.color,
      this.weight,
      required this.size,
      this.textAlign});
  final String text;
  final Color color;
  final FontWeight? weight;
  final double size;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color, fontWeight: weight, fontSize: size),
    );
  }
}
