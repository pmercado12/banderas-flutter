import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

class Franja {
  Color colorCorrecto;
  int flex;
  Color colorActual;

  Franja({required this.colorCorrecto, required this.flex})
    : colorActual = Colors.transparent;

  Franja copy() {
    return Franja(colorCorrecto: colorCorrecto, flex: flex)
      ..colorActual = colorCorrecto;
  }
}
