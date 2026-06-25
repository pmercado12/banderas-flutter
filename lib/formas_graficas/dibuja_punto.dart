import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/modelo_punto.dart';

class DibujaPunto extends CustomPainter {
  List<ModeloPunto> vPunto;
  DibujaPunto(this.vPunto);

  @override
  void paint(Canvas canvas, Size size) {
    Paint brocha = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;

    vPunto.forEach((ele) {
      brocha.color = ele.color;
      canvas.drawCircle(Offset(ele.x, ele.y), ele.radio, brocha);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
