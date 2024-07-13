import 'package:flutter/material.dart';
import 'AddRegistroPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Espetaria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('registrosDiarios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Espetaria'),
      ),
      body: StreamBuilder(
        stream: _database.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
            return Center(child: Text('Nenhum registro encontrado.'));
          }

          Map<dynamic, dynamic> registros = snapshot.data!.snapshot.value;
          List<RegistroDiario> registrosList = [];

          registros.forEach((key, value) {
            registrosList.add(RegistroDiario.fromMap(key, value));
          });

          return ListView.builder(
            itemCount: registrosList.length,
            itemBuilder: (context, index) {
              final registro = registrosList[index];
              return ListTile(
                title: Text('Data: ${registro.data}'),
                subtitle: Text('Total Arrecadado: R\$ ${registro.totalArrecadado.toStringAsFixed(2)}'),
                onTap: () {
                  // Implementar navegação para detalhes do registro, se necessário
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRegistroPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RegistroDiario {
  final String id;
  final String data;
  final Map<String, int> levados;
  final Map<String, int> sobrou;
  final double totalArrecadado;

  RegistroDiario({
    required this.id,
    required this.data,
    required this.levados,
    required this.sobrou,
    required this.totalArrecadado,
  });

  factory RegistroDiario.fromMap(String id, Map<dynamic, dynamic> data) {
    return RegistroDiario(
      id: id,
      data: data['data'] as String,
      levados: Map<String, int>.from(data['levados']),
      sobrou: Map<String, int>.from(data['sobrou']),
      totalArrecadado: _calcularTotalArrecadado(data['levados']),
    );
  }

  static double _calcularTotalArrecadado(Map<dynamic, dynamic> levados) {
    double total = 0.0;

    // Recupera os dados de preço dos espetinhos (substitua pelos dados reais do Firebase)
    Map<String, double> precos = {
      'Carne': 4.0, // Preço da carne
      'Linguica': 4.0, // Preço da linguiça
    };

    levados.forEach((tipo, quantidade) {
      if (precos.containsKey(tipo)) {
        total += quantidade * precos[tipo]!;
      }
    });

    return total;
  }
}
