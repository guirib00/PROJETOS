import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String numero = "Numero";

  void calcular(String tecla) {
    setState(() {
      switch (tecla) {
        case '0':
          numero += tecla;
          break;
        case '1':
          numero += tecla;
          break;
        case '2':
          numero += tecla;
          break;
        case '3':
          numero += tecla;
          break;
        case '4':
          numero += tecla;
          break;
        case '5':
          numero += tecla;
          break;
        case '6':
          numero += tecla;
          break;
        case '7':
          numero += tecla;
          break;
        case '8':
          numero += tecla;
          break;
        case '9':
          numero += tecla;
          break;
        case 'AC':
          numero = "0";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: const Text(
                'Calculadora',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(numero, style: TextStyle(fontSize: 72)),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      calcular('AC');
                    },
                    child: Text(
                      "AC",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  Text(
                    " ",
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    " ",
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    "<X",
                    style: TextStyle(fontSize: 48),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      calcular('7');
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      calcular('8');
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      calcular('9');
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      calcular('/');
                    },
                    child: Text(
                      "/",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => calcular('4'),
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('5'),
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('6'),
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('x'),
                    child: Text(
                      "x",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => calcular('1'),
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('2'),
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('3'),
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(fontSize: 48),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => calcular('0'),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular(','),
                    child: Text(
                      ",",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('='),
                    child: Text(
                      "=",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => calcular('+'),
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ],
              ),
              Text("Coluna 6"),
            ],
          )),
    );
  }
}
