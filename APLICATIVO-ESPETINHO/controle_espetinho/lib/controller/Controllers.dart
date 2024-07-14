import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PageControllers {
  static final TextEditingController dataController = TextEditingController();
  static final TextEditingController levadosCarneController = TextEditingController();
  static final TextEditingController levadosLinguicaController = TextEditingController();
  static final TextEditingController levadosLinguicaApimentadaController = TextEditingController();
  static final TextEditingController levadosFrangoController = TextEditingController();
  static final TextEditingController levadosPernilController = TextEditingController();
  static final TextEditingController levadosCoracaoController = TextEditingController();
  static final TextEditingController levadosQueijoController = TextEditingController();
  static final TextEditingController levadosPaoController = TextEditingController();
  static final TextEditingController sobrouCarneController = TextEditingController();
  static final TextEditingController sobrouLinguicaController = TextEditingController();
  static final TextEditingController sobrouLinguicaApimentadaController = TextEditingController();
  static final TextEditingController sobrouFrangoController = TextEditingController();
  static final TextEditingController sobrouPernilController = TextEditingController();
  static final TextEditingController sobrouCoracaoController = TextEditingController();
  static final TextEditingController sobrouQueijoController = TextEditingController();
  static final TextEditingController sobrouPaoController = TextEditingController();
  static final database = FirebaseDatabase.instance.reference().child('registrosDiarios');
}
