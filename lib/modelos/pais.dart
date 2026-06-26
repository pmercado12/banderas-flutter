import 'package:mi_paint/modelos/franja.dart';

enum TipoBandera { horizontal, vertical }

class Pais {
  String nombre;
  TipoBandera tipo;
  List<Franja> franjas;

  Pais({required this.nombre, required this.tipo, required this.franjas});

  Pais copy() {
    return Pais(
      nombre: nombre,
      tipo: tipo,
      franjas: franjas.map((f) => f.copy()).toList(),
    );
  }
}
