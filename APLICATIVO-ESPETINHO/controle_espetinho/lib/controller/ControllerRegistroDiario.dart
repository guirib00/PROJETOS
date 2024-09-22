import '../calculos/CalcularTotalArrecadado.dart';

class RegistroDiario {
  final String id;
  String data;
  Map<String, int> levados;
  Map<String, int> sobrou;
  double totalArrecadado;

  RegistroDiario({
    required this.id,
    required this.data,
    required this.levados,
    required this.sobrou,
    this.totalArrecadado = 0.0,
  });

  factory RegistroDiario.fromMap(String id, Map<dynamic, dynamic> data) {
    return RegistroDiario(
      id: id,
      data: data['data'] as String,
      levados: Map<String, int>.from(data['levados']),
      sobrou: Map<String, int>.from(data['sobrou']),
      totalArrecadado: calcularTotalArrecadado(
        Map<String, int>.from(data['levados']),
        Map<String, int>.from(data['sobrou']),
      ),
    );
  }
}

