import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'addRegistroPage.dart';
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
        scaffoldBackgroundColor: Colors.grey[900], 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900], 
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 187, 187, 187), 
        ),
        iconTheme: IconThemeData(color: Colors.white), 
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[900], 
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900], 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, 
                         image: DecorationImage(
                           image: AssetImage('images/logo.png'),
                           fit: BoxFit.cover,
                         ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "RR's Grill",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
            return Center(child: Text('Nenhum registro encontrado.', style: TextStyle(color: Colors.white)));
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
              return Card(
                elevation: 8, 
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), 
                ),
                color: Colors.grey[800], 
                child: ListTile(
                  title: Text('Data: ${registro.data}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      'Total Arrecadado: R\$ ${registro.totalArrecadado.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesRegistroPage(
                            registro: registro,
                            precos: precos),
                      ),
                    );
                  },
                ),
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
