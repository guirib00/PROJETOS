import '../controller/ControllerPrecos.dart';
double calcularTotalArrecadado(Map<String, int> levados, Map<String, int> sobrou) {
  double total = 0.0;

  levados.forEach((tipo, quantidadeLevados) {
    if (sobrou.containsKey(tipo) && precos.containsKey(tipo)) {
      total += (quantidadeLevados - sobrou[tipo]!) * precos[tipo]!;
    }
  });

  return total;
}