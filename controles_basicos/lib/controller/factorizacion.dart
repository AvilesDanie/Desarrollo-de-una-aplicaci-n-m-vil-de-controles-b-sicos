class FactorRow {
  final int originalNumber;  // Número original ingresado
  final int number;  // Número actual en proceso de factorización
  final int factor; // Factor primo encontrado

  FactorRow(this.originalNumber, this.number, this.factor);
}

// Método que descompone un número en sus factores primos
// Retorna una lista de FactorRow con la información de factorización

class Factorization {
  List<FactorRow> factorize(int n) {
    if (n == 1) {
      return [FactorRow(n, 1, 0)];
    }

    List<FactorRow> factorRows = [];
    int factor = 2;
    int currentNumber = n;
    bool isPrime = true;

    while (currentNumber > 1) {
      while (currentNumber % factor == 0) {
        factorRows.add(FactorRow(n, currentNumber, factor));
        currentNumber ~/= factor;
        isPrime = false;
      }
      factor++;
    }

    if (isPrime) {
      factorRows.add(FactorRow(n, n, 0));
    } else {
      factorRows.add(FactorRow(n, 1, 0));
    }

    return factorRows;
  }
}