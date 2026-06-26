import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/dificultad_enum.dart';
import 'package:mi_paint/modelos/pais.dart';
import 'package:mi_paint/modelos/zonabandera.dart';
import 'package:mi_paint/modelos/franja.dart';
import 'package:mi_paint/modelos/paises_data.dart';
import 'package:confetti/confetti.dart';
import 'package:mi_paint/fin_page.dart';

class BanderaArgentinaPage extends StatefulWidget {
  final Dificultad dificultad;

  const BanderaArgentinaPage({super.key, required this.dificultad});

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

  List<Color> paletaActual = [];

  late ConfettiController _confettiController;

  double escalaBandera = 1.0;

  int indicePais = 0;

  late Pais paisActual;

  int banderasCompletadas = 0;

  List<Pais> paisesFiltrados = [];

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    aplicarDificultad();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  bool banderaCorrecta() {
    for (final franja in paisActual.franjas) {
      if (franja.colorActual != franja.colorCorrecto) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pintando Banderas')),

      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                children: paisesFiltrados.map((pais) {
                  return ChoiceChip(
                    label: Text(pais.nombre),
                    selected: paisActual.nombre == pais.nombre,
                    onSelected: (_) => cambiarPais(pais),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                "🎨 ${paisActual.nombre}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 10),
              // BANDERA
              Center(
                child: AnimatedScale(
                  scale: escalaBandera,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: SizedBox(
                    height: 140,
                    width: 210,
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
                onPressed: () async {
                  final correcto = banderaCorrecta();

                  if (correcto) {
                    banderasCompletadas++;
                    _confettiController.play();
                    await animarBandera();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        correcto ? '✅ Correcto' : '❌ Intenta nuevamente',
                      ),
                    ),
                  );

                  if (!mounted) return;

                  if (correcto) {
                    await siguientePais();
                  }
                },
                child: const Text('Verificar'),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 25,
            ),
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
      paisActual = pais.copy();

      for (final f in pais.franjas) {
        f.colorActual = colorSinPintar;
      }

      for (int i = 0; i < paisesFiltrados.length; i++) {
        if (paisesFiltrados[i].nombre == pais.nombre) {
          indicePais = i;
        }
      }

      //paletaActual = pais.franjas.map((f) => f.colorCorrecto).toList();
      //paletaActual.shuffle();
      paisActual = pais;
      prepararPaleta();

      colorSeleccionado = paletaActual.first;
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

  Future<void> animarBandera() async {
    setState(() {
      escalaBandera = 1.12;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    setState(() {
      escalaBandera = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> siguientePais() async {
    indicePais++;

    if (indicePais >= paisesFiltrados.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FinPage(
            puntaje: banderasCompletadas,
            total: paisesFiltrados.length,
          ),
        ),
      );
      return;
    }
    cambiarPais(paisesFiltrados[indicePais]);
  }

  Future<void> mostrarDialogoFinal() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("🏆 ¡Felicitaciones!"),
          content: const Text("Has completado todas las banderas."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  indicePais = 0;
                });

                cambiarPais(paisesFiltrados[indicePais]);
              },
              child: const Text("Jugar de nuevo"),
            ),
          ],
        );
      },
    );
  }

  void resetPais(Pais pais) {
    for (final f in pais.franjas) {
      f.colorActual = Colors.transparent; // o colorSinPintar
    }
  }

  void aplicarDificultad() {
    setState(() {
      switch (widget.dificultad) {
        case Dificultad.facil:
          paisesFiltrados = paises.take(2).map((p) => p.copy()).toList();
          break;

        case Dificultad.intermedio:
          paisesFiltrados = paises.take(12).map((p) => p.copy()).toList();
          break;

        case Dificultad.avanzado:
          paisesFiltrados = paises.map((p) => p.copy()).toList();
          break;
      }

      indicePais = 0;
      paisActual = paisesFiltrados[indicePais];
      resetPais(paisActual);
      prepararPaleta();
    });
  }

  void prepararPaleta() {
    paletaActual = paisActual.franjas.map((f) => f.colorCorrecto).toList();

    if (widget.dificultad == Dificultad.intermedio) {
      paletaActual.addAll([Colors.grey, Colors.brown]);
    }

    if (widget.dificultad == Dificultad.avanzado) {
      paletaActual.addAll([
        Colors.black,
        Colors.grey,
        Colors.brown,
        Colors.orange,
        Colors.pink,
        Colors.purple,
        Colors.teal,
      ]);
    }

    paletaActual.shuffle();
    colorSeleccionado = paletaActual.first;
  }
}
