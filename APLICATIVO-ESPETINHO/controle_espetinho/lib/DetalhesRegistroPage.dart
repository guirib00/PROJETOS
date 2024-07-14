import 'package:flutter/material.dart';
import 'EditRegistroPage.dart';
import 'controller/ControllerRegistroDiario.dart';

class DetalhesRegistroPage extends StatelessWidget {
  final RegistroDiario registro;
  final Map<String, double> precos;

  DetalhesRegistroPage({required this.registro, required this.precos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Registro',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.grey[900], // Cor de fundo da AppBar
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditRegistroPage(registroEdit: registro),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900], // Cor de fundo do Scaffold
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataSection(),
            SizedBox(height: 16),
            _buildEspetosSection('Espetos Levados', registro.levados),
            SizedBox(height: 16),
            _buildEspetosSection('Espetos Sobraram', registro.sobrou),
            SizedBox(height: 16),
            _buildTotalArrecadadoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data: ${registro.data}',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildEspetosSection(String title, Map<String, int> espetos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: espetos.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key}:',
                      style: TextStyle(color: Colors.white)),
                  Text('${entry.value}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTotalArrecadadoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Arrecadado: R\$ ${registro.totalArrecadado.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
