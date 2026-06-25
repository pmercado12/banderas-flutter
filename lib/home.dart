import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mi_paint/formas_graficas/dibuja_punto.dart';
import 'package:mi_paint/modelos/modelo_punto.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 200, y = 300, radio = 10;
  Color colorPorDefecto = Colors.black;
  List<ModeloPunto> vPunto = [];

  Future<void> paleta(BuildContext context) async {
    Color colorTmp = colorPorDefecto;
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('elige color'),
          content: ColorPicker(
            pickerColor: colorTmp,
            onColorChanged: (Color color) {
              colorTmp = color;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  colorPorDefecto = colorTmp;
                  Navigator.of(dialogContext).pop();
                });
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(painter: DibujaPunto(vPunto)),
          GestureDetector(
            onPanUpdate: (des) {
              setState(() {
                x = des.globalPosition.dx;
                y = des.globalPosition.dy;
                vPunto.add(ModeloPunto(x, y, radio, colorPorDefecto));
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Slider(
                value: radio,
                min: 1,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    radio = value;
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  vPunto.clear();
                });
              },
              icon: Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  paleta(context);
                });
              },
              icon: Icon(Icons.palette_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
