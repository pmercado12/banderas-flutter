import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

class Franja {
  Color colorCorrecto;
  Color colorActual;
  int flex;

  Franja({
    required this.colorCorrecto,
    this.colorActual = const Color(0xFFF0F0F0),
    this.flex = 1,
  });
}
