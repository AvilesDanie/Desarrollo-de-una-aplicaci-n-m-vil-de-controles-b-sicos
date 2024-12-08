import 'package:flutter/material.dart';
import './view/bienvenida.dart';
import './view/ejer1.dart';
import './view/ejer2.dart';
import './view/ejer3.dart';
import './view/ejer4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Bienvenida(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/ejer1': (context) => pantallaAscii(),
        '/ejer2': (context) => PantallaPrincipal(),
        '/ejer3': (context) => Ejer3(),
        '/ejer4': (context) => FactorizationScreen(),
      },
    );

  }
}
