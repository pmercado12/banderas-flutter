import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/pais.dart';
import 'package:mi_paint/modelos/zonabandera.dart';

class BanderaArgentinaPage extends StatefulWidget {
  const BanderaArgentinaPage({super.key});

  @override
  State<BanderaArgentinaPage> createState() => _BanderaArgentinaPageState();
}

class _BanderaArgentinaPageState extends State<BanderaArgentinaPage> {
  Color colorSeleccionado = Colors.lightBlue;
  static const Color colorSinPintar = Color(0xFFF0F0F0);

  final zonaSuperior = ZonaBandera(colorCorrecto: Colors.lightBlue);
  final zonaCentral = ZonaBandera(colorCorrecto: Colors.white);
  final zonaInferior = ZonaBandera(colorCorrecto: Colors.lightBlue);

  final List<Pais> paises = [
    Pais(
      nombre: 'Argentina',
      franjas: [Colors.lightBlue, Colors.white, Colors.lightBlue],
      tipo: TipoBandera.horizontal,
    ),

    Pais(
      nombre: 'Francia',
      franjas: [Colors.blue, Colors.white, Colors.red],
      tipo: TipoBandera.vertical,
    ),

    Pais(
      nombre: 'Italia',
      franjas: [Colors.green, Colors.white, Colors.red],
      tipo: TipoBandera.vertical,
    ),
  ];

  Pais paisActual = const Pais(
    nombre: "Argentina",
    franjas: [Colors.lightBlue, Colors.white, Colors.lightBlue],
    tipo: TipoBandera.horizontal,
  );

  List<Color> paletaActual = [];

  @override
  void initState() {
    super.initState();

    paletaActual = paisActual.franjas.toSet().toList();
    paletaActual.shuffle();
  }

  void pintarZona(ZonaBandera zona) {
    setState(() {
      zona.colorActual = colorSeleccionado;
    });
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
            children: paletaActual.map((color) => colorBoton(color)).toList(),
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

      zonaSuperior.colorCorrecto = pais.franjas[0];
      zonaCentral.colorCorrecto = pais.franjas[1];
      zonaInferior.colorCorrecto = pais.franjas[2];

      // limpiar la bandera
      zonaSuperior.colorActual = colorSinPintar;
      zonaCentral.colorActual = colorSinPintar;
      zonaInferior.colorActual = colorSinPintar;

      // seleccionar un color por defecto
      paletaActual = pais.franjas.toSet().toList();
      paletaActual.shuffle();

      colorSeleccionado = paletaActual.first;
    });
  }

  Widget banderaHorizontal() {
    return Column(
      children: [
        zonaWidget(zonaSuperior),
        Container(height: 2, color: Colors.black),
        zonaWidget(zonaCentral),
        Container(height: 2, color: Colors.black),
        zonaWidget(zonaInferior),
      ],
    );
  }

  Widget banderaVertical() {
    return Row(
      children: [
        zonaWidget(zonaSuperior),
        Container(width: 2, color: Colors.black),
        zonaWidget(zonaCentral),
        Container(width: 2, color: Colors.black),
        zonaWidget(zonaInferior),
      ],
    );
  }

  Widget zonaWidget(ZonaBandera zona) {
    return Expanded(
      child: GestureDetector(
        onTap: () => pintarZona(zona),
        child: Container(color: zona.colorActual),
      ),
    );
  }
}
