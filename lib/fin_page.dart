import 'package:flutter/material.dart';
import 'inicio_page.dart';

class FinPage extends StatelessWidget {
  final int puntaje;
  final int total;

  const FinPage({super.key, required this.puntaje, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E0), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🏆", style: TextStyle(fontSize: 80)),

            const SizedBox(height: 10),

            const Text(
              "¡Felicitaciones!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Completaste todas las banderas",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            const SizedBox(height: 30),

            Text(
              "$puntaje / $total",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const InicioPage()),
                  (route) => false,
                );
              },
              child: const Text("Jugar de nuevo"),
            ),
          ],
        ),
      ),
    );
  }
}
