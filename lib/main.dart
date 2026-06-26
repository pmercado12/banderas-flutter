import 'package:flutter/material.dart';
import 'package:mi_paint/banderas/banderaargentina.dart';
import 'package:mi_paint/home.dart';
import 'inicio_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return const MaterialApp(home: Home());
    //return const MaterialApp(home: BanderaArgentinaPage());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InicioPage(),
    );
  }
}
