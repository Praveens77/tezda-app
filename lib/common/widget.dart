import 'package:flutter/material.dart';


// LIGHT TEXTS --------->>>
// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  String family;
  FontWeight weight;

  CustomText(this.text, this.color, this.size, this.family, this.weight,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: size, fontWeight: weight, fontFamily: family),
    );
  }
}

// ignore: must_be_immutable
class ParagraphText extends StatelessWidget {
  String text;
  Color color;
  double size;
  String family;
  FontWeight weight;
  TextAlign alignment;

  ParagraphText(this.text, this.color, this.size, this.family, this.weight,
      this.alignment,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      style: TextStyle(
          color: color, fontSize: size, fontWeight: weight, fontFamily: family),
    );
  }
}
