import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/pais.dart';
import 'package:mi_paint/modelos/franja.dart';

final List<Pais> paisesData = [
  Pais(
    nombre: 'Argentina',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.lightBlue, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.lightBlue, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Francia',
    tipo: TipoBandera.vertical,
    franjas: [
      Franja(colorCorrecto: Colors.blue, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Italia',
    tipo: TipoBandera.vertical,
    franjas: [
      Franja(colorCorrecto: Colors.green, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Alemania',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.black, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.yellow, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Costa de Marfil',
    tipo: TipoBandera.vertical,
    franjas: [
      Franja(colorCorrecto: Color(0xFFF77F00), flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Color(0xFF009E60), flex: 1),
    ],
  ),

  Pais(
    nombre: 'Paises Bajos',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Color(0xFF21468B), flex: 1),
    ],
  ),

  Pais(
    nombre: 'Egipto',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.black, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Belgica',
    tipo: TipoBandera.vertical,
    franjas: [
      Franja(colorCorrecto: Colors.black, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.yellow, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Irak',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.black, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Austria',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Uzbekistan',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Color(0xFF0099B5), flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Color(0xFF1EB53A), flex: 1),
    ],
  ),

  Pais(
    nombre: 'Ghana',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.yellow, flex: 1),
      Franja(colorCorrecto: Colors.green, flex: 1),
    ],
  ),

  Pais(
    nombre: 'España',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.red, flex: 1),
      Franja(colorCorrecto: Colors.yellow, flex: 2),
      Franja(colorCorrecto: Colors.red, flex: 1),
    ],
  ),

  Pais(
    nombre: 'Colombia',
    tipo: TipoBandera.horizontal,
    franjas: [
      Franja(colorCorrecto: Colors.yellow, flex: 2),
      Franja(colorCorrecto: Colors.blue, flex: 1),
      Franja(colorCorrecto: Colors.red, flex: 1),
    ],
  ),
];
