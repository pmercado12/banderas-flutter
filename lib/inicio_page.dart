import 'package:flutter/material.dart';
import 'package:mi_paint/modelos/dificultad_enum.dart';
import 'banderas/banderaargentina.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  Dificultad dificultadSeleccionada = Dificultad.facil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🌍", style: TextStyle(fontSize: 80)),

            const SizedBox(height: 10),

            const Text(
              "PAINT FLAGS",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Aprende las banderas del mundo\npintándolas",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            Column(
              children: [
                dificultadBoton("🟢 Fácil", Dificultad.facil),
                const SizedBox(height: 10),
                dificultadBoton("🟡 Intermedio", Dificultad.intermedio),
                const SizedBox(height: 10),
                dificultadBoton("🔴 Avanzado", Dificultad.avanzado),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BanderaArgentinaPage(
                      dificultad: dificultadSeleccionada,
                    ),
                  ),
                );
              },
              child: const Text("JUGAR"),
            ),
          ],
        ),
      ),
    );
  }

  Widget dificultadBoton(String texto, Dificultad dificultad) {
    final seleccionado = dificultadSeleccionada == dificultad;

    return GestureDetector(
      onTap: () {
        setState(() {
          dificultadSeleccionada = dificultad;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: seleccionado ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue, width: 2),
          boxShadow: [
            if (seleccionado)
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: seleccionado ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
