import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/factorizacion.dart';

class FactorizationScreen extends StatefulWidget {
  const FactorizationScreen({super.key});

  @override
  _FactorizationScreenState createState() => _FactorizationScreenState();
}

class _FactorizationScreenState extends State<FactorizationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<FactorRow> _factorRows = [];
  String _message = '';

  void _factorizeNumber() {
    final int number = int.tryParse(_controller.text) ?? 0;
    if (number > 0) {
      final List<FactorRow> factorRows = Factorization().factorize(number);
      setState(() {
        _factorRows = factorRows;
        if (number == 1) {
          _message = 'El número 1, por convenio, no se considera ni primo ni compuesto';
        } else if (factorRows.length == 2 && factorRows[0].factor == 0) {
          _message = 'El número $number es primo y no se puede descomponer en factores';
        } else {
          _message = '';
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, introduce un número entero positivo mayor a 0')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factorización de Números', style: TextStyle(color: Color(0xFFF5F7FA))),
        backgroundColor: const Color(0xFF4A90E2),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F7FA), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$')),
              ],
              decoration: InputDecoration(
                labelText: 'Introduce un número entero',
                labelStyle: const TextStyle(color: Color(0xFF4A4A4A)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.calculate, color: Color(0xFF4A90E2)),
                filled: true,
                fillColor: const Color(0xFFF5F7FA),
              ),
              style: const TextStyle(color: Color(0xFF4A4A4A)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _factorizeNumber,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD0021B),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Factorizar', style: TextStyle(color: Color(0xFFF5F7FA))),
            ),
            const SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(color: Color(0xFFD0021B), fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _factorRows.length,
                itemBuilder: (context, index) {
                  final factorRow = _factorRows[index];
                  return ListTile(
                    leading: factorRow.factor > 0
                        ? Text(factorRow.number.toString(), style: const TextStyle(color: Color(0xFF4A4A4A), fontWeight: FontWeight.bold, fontSize: 14))
                        : const SizedBox.shrink(),
                    title: Row(
                      children: [
                        if (factorRow.factor > 0)
                          Text(
                            '| ${factorRow.factor} ',
                            style: const TextStyle(color: Color(0xFF4A4A4A)),
                          ),
                        if (factorRow.factor > 0)
                          Text(
                            ' (${factorRow.number} : ${factorRow.factor} = ${factorRow.number ~/ factorRow.factor})',
                            style: const TextStyle(color: Color(0xFF4A90E2)),
                          ),
                      ],
                    ),
                    tileColor: const Color(0xFFF5F7FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Color(0xFF4A90E2)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_factorRows.isNotEmpty && _message.isEmpty)
              Text(
                '${_factorRows.first.originalNumber} = ${_factorRows.where((row) => row.factor > 0).map((row) => '${row.factor}').join(' * ')} = ${_factorRows.where((row) => row.factor > 0).fold<Map<int, int>>({}, (map, row) {
                  map[row.factor] = (map[row.factor] ?? 0) + 1;
                  return map;
                }).entries.map((entry) => '${entry.key}^${entry.value}').join(' * ')}',
                style: const TextStyle(color: Color(0xFF4A4A4A), fontWeight: FontWeight.bold, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}