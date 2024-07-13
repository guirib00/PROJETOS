import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddRegistroPage extends StatefulWidget {
  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('registrosDiarios');
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _levadosCarneController = TextEditingController();
  final TextEditingController _levadosLinguicaController = TextEditingController();
  final TextEditingController _sobrouCarneController = TextEditingController();
  final TextEditingController _sobrouLinguicaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Registro Diário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _levadosCarneController,
              decoration: InputDecoration(labelText: 'Espetos de Carne Levados'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _levadosLinguicaController,
              decoration: InputDecoration(labelText: 'Espetos de Linguiça Levados'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sobrouCarneController,
              decoration: InputDecoration(labelText: 'Espetos de Carne Sobrados'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sobrouLinguicaController,
              decoration: InputDecoration(labelText: 'Espetos de Linguiça Sobrados'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final data = _dataController.text;
                final levadosCarne = int.parse(_levadosCarneController.text);
                final levadosLinguica = int.parse(_levadosLinguicaController.text);
                final sobrouCarne = int.parse(_sobrouCarneController.text);
                final sobrouLinguica = int.parse(_sobrouLinguicaController.text);

                await _adicionarRegistro(data, levadosCarne, levadosLinguica, sobrouCarne, sobrouLinguica);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _adicionarRegistro(String data, int levadosCarne, int levadosLinguica, int sobrouCarne, int sobrouLinguica) async {
    await _database.push().set({
      'data': data,
      'levados': {
        'Carne': levadosCarne,
        'Linguica': levadosLinguica,
      },
      'sobrou': {
        'Carne': sobrouCarne,
        'Linguica': sobrouLinguica,
      },
    });
  }
}
