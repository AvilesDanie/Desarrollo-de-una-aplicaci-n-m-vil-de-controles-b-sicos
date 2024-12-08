import 'package:flutter/material.dart';
import '../controller/logica_factorial.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final TextEditingController _controladorNumero = TextEditingController();
  String _resultado = "";

  void _calcularFactorial() {
    try {
      final int numero = int.parse(_controladorNumero.text);
      final int factorial = calcularFactorial(numero);

      setState(() {
        _resultado = "El factorial de $numero es: $factorial";
      });
    } catch (e) {
      setState(() {
        _resultado = "Por favor, ingresa un número válido.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de Factorial"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorNumero,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Número",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calculate),
              ),
            ),
            SizedBox(height: 20),
        ElevatedButton(
          onPressed: _calcularFactorial,
          child: Text("Calcular Factorial"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Color del botón
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
            SizedBox(height: 20),
            Text(
              _resultado,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
