import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

enum TipoBandera { horizontal, vertical }

class Pais {
  final String nombre;
  final List<Color> franjas;
  final TipoBandera tipo;

  const Pais({required this.nombre, required this.franjas, required this.tipo});
}
