int calcularFactorial(int numero) {
  if (numero < 0) {
    throw ArgumentError("El número debe ser no negativo");
  }

  int factorial = 1;
  for (int i = 1; i <= numero; i++) {
    factorial *= i;
  }
  return factorial;
}
