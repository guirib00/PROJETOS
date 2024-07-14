import 'package:flutter/material.dart';
import 'EditRegistroPage.dart'; // Importe com alias
import 'controller/ControllerRegistroDiario.dart';

class DetalhesRegistroPage extends StatelessWidget {
  final RegistroDiario registro;
  final Map<String, double> precos; // Adicione esta linha

  DetalhesRegistroPage({required this.registro, required this.precos}); // Adicione precos ao construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Registro'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditRegistroPage(registroEdit: registro), // Passe os preços aqui
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data: ${registro.data}'),
              SizedBox(height: 8),
              Text('Espetos Levados:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: registro.levados.entries.map((entry) {
                  return Text('${entry.key}: ${entry.value}');
                }).toList(),
              ),
              SizedBox(height: 8),
              Text('Espetos Sobraram:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: registro.sobrou.entries.map((entry) {
                  return Text('${entry.key}: ${entry.value}');
                }).toList(),
              ),
              SizedBox(height: 8),
              Text(
                  'Total Arrecadado: R\$ ${registro.totalArrecadado.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
