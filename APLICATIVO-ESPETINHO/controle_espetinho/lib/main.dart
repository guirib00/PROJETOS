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
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('registrosDiarios');
  String? selectedYear;
  String? selectedMonth;
  List<String> years = [];
  List<String> months = [
    '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
  ];

  @override
  void initState() {
    super.initState();
    fetchYears();
  }

  void fetchYears() async {
    DatabaseEvent event = await _database.once();
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic> registros = Map<dynamic, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    Set<String> yearSet = {};

    registros.forEach((key, value) {
      String date = value['data'];
      String year = date.split('-')[0];
      yearSet.add(year);
    });

    setState(() {
      years = yearSet.toList();
    });
  }

  void clearFilters() {
    setState(() {
      selectedYear = null;
      selectedMonth = null;
    });
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: Text('Ano', style: TextStyle(color: Colors.white)),
                  value: selectedYear,
                  dropdownColor: Colors.grey[800], // Define a cor do menu suspenso
                  style: TextStyle(color: Colors.white), // Define a cor do texto
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                  },
                  items: years.map((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                DropdownButton<String>(
                  hint: Text('Mês', style: TextStyle(color: Colors.white)),
                  value: selectedMonth,
                  dropdownColor: Colors.grey[800], // Define a cor do menu suspenso
                  style: TextStyle(color: Colors.white), // Define a cor do texto
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue;
                    });
                  },
                  items: months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: clearFilters,
                  child: Text('Limpar Filtros'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
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

                if (selectedYear != null || selectedMonth != null) {
                  registrosList = registrosList.where((registro) {
                    String year = registro.data.split('-')[0];
                    String month = registro.data.split('-')[1];
                    bool matchesYear = selectedYear == null || year == selectedYear;
                    bool matchesMonth = selectedMonth == null || month == selectedMonth;
                    return matchesYear && matchesMonth;
                  }).toList();
                }

                // Ordena a lista de registros pela data, da mais recente para a mais antiga
                registrosList.sort((a, b) => b.data.compareTo(a.data));

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
          ),
        ],
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
