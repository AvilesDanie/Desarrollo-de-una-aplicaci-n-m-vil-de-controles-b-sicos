import 'package:flutter/material.dart';
import '../controller/logica_mcd.dart';

class Ejer3 extends StatefulWidget {
  const Ejer3({Key? key}) : super(key: key);

  @override
  _Ejer3State createState() => _Ejer3State();
}

class _Ejer3State extends State<Ejer3> {
  final mcd _controller = mcd();
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String _resultado = "";

  void _calcularMCD() {
    final int? num1 = int.tryParse(_num1Controller.text);
    final int? num2 = int.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null || num1 <= 0 || num2 <= 0) {
      setState(() {
        _resultado = "Por favor, introduce números válidos mayores que 0.";
      });
      return;
    }

    final int mcd = _controller.calcularMCD(num1, num2);

    setState(() {
      _resultado = "El MCD de $num1 y $num2 es: $mcd";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo del MCD"),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _num1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Primer Número",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.looks_one),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _num2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Segundo Número",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.looks_two),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calcularMCD,
                    child: const Text("Calcular MCD"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
