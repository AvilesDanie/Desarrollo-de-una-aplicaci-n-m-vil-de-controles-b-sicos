import 'package:flutter/material.dart';
import '../controller/ascii_logica.dart';

class pantallaAscii extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PantallaAsciiState();
}

class _PantallaAsciiState extends State<pantallaAscii> {
  final AsciiLogica _asciiLogica = AsciiLogica();
  final int _columna = 5;
  final int _fila = 10;
  int _actualAscii= 0;
  int paginacion=1;

  //generar el texto ascii
  String textoAscii(int index) {
    int evaluarAscii = _actualAscii+ index;
    if (evaluarAscii <= 255)
    {
      String asciiChar = _asciiLogica.convertiAscii(evaluarAscii);
      return '$evaluarAscii = $asciiChar';
    }
    else
    {
      return '';
    }
  }
// evaluar que no se pase del numero de ascii en las paginas
  void siguienteAscii() {
    setState(() {
      if (_actualAscii+ _columna * _fila <= 255) {
        _actualAscii += _columna * _fila;
        paginacion++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("¡Se alcanzó el valor máximo de 255!")),
        );
      }
    });
  }
  // evaluar que no se pase del numero de ascii en las paginas
  void anteriorAscii() {
    setState(() {
      if (_actualAscii - _columna * _fila >= 0) {
        _actualAscii -= _columna * _fila;
        paginacion--;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("¡Ya estás en la primera página!")),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla ASCII'),
        backgroundColor: Colors.deepPurple
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Título
            Text(
              'Valores ASCII:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _columna,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _columna * _fila,
                itemBuilder: (context, index) {
                  String asciiTexto = textoAscii(index);
                  return
                    Card(
                    color: Colors.indigoAccent,
                    elevation: 4,
                    child: Center(
                      child: Text(
                        asciiTexto,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(
                onPressed: anteriorAscii,
                child: Icon(Icons.arrow_back),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(width:10),
              Text(paginacion.toString(),
                style: TextStyle
                  (
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(width:10),
              ElevatedButton(
                onPressed: siguienteAscii,
                child: Icon(Icons.arrow_forward_rounded),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
            ),
          ],
        ),
      ),
    );
  }
}
