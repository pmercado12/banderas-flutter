import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/pais.dart';
import 'package:mi_paint/modelos/zonabandera.dart';
import 'package:mi_paint/modelos/franja.dart';
import 'package:mi_paint/modelos/paises_data.dart';

class BanderaArgentinaPage extends StatefulWidget {
  const BanderaArgentinaPage({super.key});

  @override
  State<BanderaArgentinaPage> createState() => _BanderaArgentinaPageState();
}

class _BanderaArgentinaPageState extends State<BanderaArgentinaPage> {
  Color colorSeleccionado = Colors.lightBlue;
  static Color colorSinPintar = Color(0xFFF0F0F0);

  final zonaSuperior = ZonaBandera(colorCorrecto: Colors.lightBlue);
  final zonaCentral = ZonaBandera(colorCorrecto: Colors.white);
  final zonaInferior = ZonaBandera(colorCorrecto: Colors.lightBlue);

  final List<Pais> paises = paisesData;

  Pais paisActual = Pais(
    nombre: "Argentina",
    franjas: [
      Franja(colorCorrecto: Colors.lightBlue, flex: 1),
      Franja(colorCorrecto: Colors.white, flex: 1),
      Franja(colorCorrecto: Colors.lightBlue, flex: 1),
    ],
    tipo: TipoBandera.horizontal,
  );

  List<Color> paletaActual = [];

  @override
  void initState() {
    super.initState();

    paletaActual = paisActual.franjas.map((f) => f.colorCorrecto).toList();
    paletaActual.shuffle();
  }

  bool banderaCorrecta() {
    return zonaSuperior.colorActual == zonaSuperior.colorCorrecto &&
        zonaCentral.colorActual == zonaCentral.colorCorrecto &&
        zonaInferior.colorActual == zonaInferior.colorCorrecto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pinta Argentina')),

      body: Column(
        children: [
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: paises.map((pais) {
              return ChoiceChip(
                label: Text(pais.nombre),
                selected: paisActual.nombre == pais.nombre,
                onSelected: (_) => cambiarPais(pais),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // BANDERA
          Center(
            child: SizedBox(
              height: 140, // 👈 controla el tamaño
              width: 210, // 3:2 proporcional
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: paisActual.tipo == TipoBandera.horizontal
                    ? banderaHorizontal()
                    : banderaVertical(),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // COLORES
          Wrap(
            spacing: 10,
            children: paletaActual
                .toSet()
                .map((color) => colorBoton(color))
                .toList(),
          ),

          const SizedBox(height: 20),

          // BOTÓN
          ElevatedButton(
            onPressed: () {
              final correcto = banderaCorrecta();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    correcto ? '✅ Correcto' : '❌ Intenta nuevamente',
                  ),
                ),
              );
            },
            child: const Text('Verificar'),
          ),
        ],
      ),
    );
  }

  Widget colorBoton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          colorSeleccionado = color;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: colorSeleccionado == color ? 4 : 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void cambiarPais(Pais pais) {
    setState(() {
      paisActual = pais;

      for (final f in pais.franjas) {
        f.colorActual = colorSinPintar;
      }

      paletaActual = pais.franjas.map((f) => f.colorCorrecto).toList();
      paletaActual.shuffle();

      colorSeleccionado = paletaActual.first;
    });
  }

  void pintarColor(Color color) {
    setState(() {
      if (zonaSuperior.colorActual == colorSinPintar) {
        zonaSuperior.colorActual = color;
        return;
      }

      if (zonaCentral.colorActual == colorSinPintar) {
        zonaCentral.colorActual = color;
        return;
      }

      if (zonaInferior.colorActual == colorSinPintar) {
        zonaInferior.colorActual = color;
        return;
      }
    });
  }

  Widget banderaHorizontal() {
    final widgets = <Widget>[];

    for (int i = 0; i < paisActual.franjas.length; i++) {
      final f = paisActual.franjas[i];

      widgets.add(
        Expanded(
          flex: f.flex,
          child: GestureDetector(
            onTap: () {
              setState(() {
                f.colorActual = colorSeleccionado;
              });
            },
            child: Container(color: f.colorActual),
          ),
        ),
      );

      // 🔥 línea separadora (excepto la última)
      if (i != paisActual.franjas.length - 1) {
        widgets.add(Container(height: 2, color: Colors.black));
      }
    }

    return Column(children: widgets);
  }

  Widget banderaVertical() {
    final widgets = <Widget>[];

    for (int i = 0; i < paisActual.franjas.length; i++) {
      final f = paisActual.franjas[i];

      widgets.add(
        Expanded(
          flex: f.flex,
          child: GestureDetector(
            onTap: () {
              setState(() {
                f.colorActual = colorSeleccionado;
              });
            },
            child: Container(color: f.colorActual),
          ),
        ),
      );

      // 🔥 separador vertical
      if (i != paisActual.franjas.length - 1) {
        widgets.add(Container(width: 2, color: Colors.black));
      }
    }

    return Row(children: widgets);
  }
}
