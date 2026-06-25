import 'package:mi_paint/modelos/franja.dart';

enum TipoBandera { horizontal, vertical }

class Pais {
  final String nombre;
  final List<Franja> franjas;
  final TipoBandera tipo;

  const Pais({required this.nombre, required this.franjas, required this.tipo});
}
