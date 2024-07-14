import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'addRegistroPage.dart'; // Verifique se o nome do arquivo está correto
import 'DetalhesRegistroPage.dart';
import 'controller/ControllerRegistroDiario.dart';
import 'controller/ControllerPrecos.dart';

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
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('registrosDiarios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Controle de Espetaria',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black, // Define a cor de fundo do Drawer como preto
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.black), // Cor de fundo do cabeçalho
              ),
              ListTile(
                title: Text(
                  'Adicionar Registro Diário',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRegistroPage()),
                  );
                },
              ),
            ],
          ),
        ),
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
                subtitle: Text(
                    'Total Arrecadado: R\$ ${registro.totalArrecadado.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesRegistroPage(
                          registro: registro,
                          precos: precos), // Passe os preços aqui
                    ),
                  );
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
