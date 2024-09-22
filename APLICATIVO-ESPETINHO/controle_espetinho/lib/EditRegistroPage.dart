import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'controller/ControllerRegistroDiario.dart';
import 'controller/ControllerPrecos.dart';

class EditRegistroPage extends StatefulWidget {
  RegistroDiario registroEdit;

  EditRegistroPage({required this.registroEdit});

  @override
  _EditRegistroPageState createState() => _EditRegistroPageState();
}

class _EditRegistroPageState extends State<EditRegistroPage> {
  final DatabaseReference _database =
      FirebaseDatabase.instance.reference().child('registrosDiarios');
  final TextEditingController _dataController = TextEditingController();
final TextEditingController _levadosCarneController = 0;
  final TextEditingController _levadosLinguicaController =
      TextEditingController();
  final TextEditingController _levadosLinguicaApimentadaController =
      TextEditingController();
  final TextEditingController _levadosFrangoController =
      TextEditingController();
  final TextEditingController _levadosPernilController =
      TextEditingController();
  final TextEditingController _levadosCoracaoController =
      TextEditingController();
  final TextEditingController _levadosQueijoController =
      TextEditingController();
  final TextEditingController _levadosPaoController = TextEditingController();
  final TextEditingController _sobrouCarneController = TextEditingController();
  final TextEditingController _sobrouLinguicaController =
      TextEditingController();
  final TextEditingController _sobrouLinguicaApimentadaController =
      TextEditingController();
  final TextEditingController _sobrouFrangoController = TextEditingController();
  final TextEditingController _sobrouPernilController = TextEditingController();
  final TextEditingController _sobrouCoracaoController =
      TextEditingController();
  final TextEditingController _sobrouQueijoController = TextEditingController();
  final TextEditingController _sobrouPaoController = TextEditingController();
  final TextEditingController _totalArrecadadoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataController.text = widget.registroEdit.data;
    _levadosCarneController.text =
        widget.registroEdit.levados['carne'].toString();
    _levadosLinguicaController.text =
        widget.registroEdit.levados['linguica'].toString();
    _levadosLinguicaApimentadaController.text =
        widget.registroEdit.levados['linguicaApimentada'].toString();
    _levadosFrangoController.text =
        widget.registroEdit.levados['frango'].toString();
    _levadosPernilController.text =
        widget.registroEdit.levados['pernil'].toString();
    _levadosCoracaoController.text =
        widget.registroEdit.levados['coracao'].toString();
    _levadosQueijoController.text =
        widget.registroEdit.levados['queijo'].toString();
    _levadosPaoController.text = widget.registroEdit.levados['pao'].toString();
    _sobrouCarneController.text =
        widget.registroEdit.sobrou['carne'].toString();
    _sobrouLinguicaController.text =
        widget.registroEdit.sobrou['linguica'].toString();
    _sobrouLinguicaApimentadaController.text =
        widget.registroEdit.sobrou['linguicaApimentada'].toString();
    _sobrouFrangoController.text =
        widget.registroEdit.sobrou['frango'].toString();
    _sobrouPernilController.text =
        widget.registroEdit.sobrou['pernil'].toString();
    _sobrouCoracaoController.text =
        widget.registroEdit.sobrou['coracao'].toString();
    _sobrouQueijoController.text =
        widget.registroEdit.sobrou['queijo'].toString();
    _sobrouPaoController.text = widget.registroEdit.sobrou['pao'].toString();
  }

  void _atualizarRegistro() async {
    var data = _dataController.text;
    var editLevados = {
      'carne': int.tryParse(_levadosCarneController.text) ?? 0,
      'linguica': int.tryParse(_levadosLinguicaController.text) ?? 0,
      'linguicaApimentada':
          int.tryParse(_levadosLinguicaApimentadaController.text) ?? 0,
      'frango': int.tryParse(_levadosFrangoController.text) ?? 0,
      'pernil': int.tryParse(_levadosPernilController.text) ?? 0,
      'coracao': int.tryParse(_levadosCoracaoController.text) ?? 0,
      'queijo': int.tryParse(_levadosQueijoController.text) ?? 0,
      'pao': int.tryParse(_levadosPaoController.text) ?? 0,
    };
    var editSobrou = {
      'carne': int.tryParse(_sobrouCarneController.text) ?? 0,
      'linguica': int.tryParse(_sobrouLinguicaController.text) ?? 0,
      'linguicaApimentada':
          int.tryParse(_sobrouLinguicaApimentadaController.text) ?? 0,
      'frango': int.tryParse(_sobrouFrangoController.text) ?? 0,
      'pernil': int.tryParse(_sobrouPernilController.text) ?? 0,
      'coracao': int.tryParse(_sobrouCoracaoController.text) ?? 0,
      'queijo': int.tryParse(_sobrouQueijoController.text) ?? 0,
      'pao': int.tryParse(_sobrouPaoController.text) ?? 0,
    };

   double acalcularTotalArrecadado(Map<String, int> editLevados, Map<String, int> editSobrou) {
  double total = 0.0;

  editLevados.forEach((tipo, quantidadeLevados) {
    if (editSobrou.containsKey(tipo) && precos.containsKey(tipo)) {
      total += (quantidadeLevados - editSobrou[tipo]!) * precos[tipo]!;
    }
  });

  return total;
}

    double totalArrecadado = acalcularTotalArrecadado(editLevados, editSobrou);

      await _database.child(widget.registroEdit.id).update({
        'data': data,
        'levados': editLevados,
        'sobrou': editSobrou,
        'totalArrecadado': totalArrecadado,
      });
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Registro', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900], // Define a cor de fundo escura
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                color: Colors.grey[800], // Cor do card mais escura
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _dataController,
                        decoration: InputDecoration(
                          labelText: 'Data (YYYY-MM-DD)',
                          labelStyle: TextStyle(
                              color: Colors.white), // Cor do texto do rótulo
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                            color: Colors.white), // Cor do texto digitado
                      ),
                      SizedBox(height: 10),
                      _buildTextField(
                          _levadosCarneController, 'Espetos de Carne Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosLinguicaController,
                          'Espetos de Linguiça Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosLinguicaApimentadaController,
                          'Espetos de Linguiça Apimentada Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosFrangoController,
                          'Espetos de Frango Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosPernilController,
                          'Espetos de Pernil Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosCoracaoController,
                          'Espetos de Coração Levados'),
                      SizedBox(height: 10),
                      _buildTextField(_levadosQueijoController,
                          'Espetos de Queijo Levados'),
                      SizedBox(height: 10),
                      _buildTextField(
                          _levadosPaoController, 'Espetos de Pão Levados'),
                      SizedBox(height: 10),
                      _buildTextField(
                          _sobrouCarneController, 'Espetos de Carne Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouLinguicaController,
                          'Espetos de Linguiça Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouLinguicaApimentadaController,
                          'Espetos de Linguiça Apimentada Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouFrangoController,
                          'Espetos de Frango Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouPernilController,
                          'Espetos de Pernil Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouCoracaoController,
                          'Espetos de Coração Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(_sobrouQueijoController,
                          'Espetos de Queijo Sobrados'),
                      SizedBox(height: 10),
                      _buildTextField(
                          _sobrouPaoController, 'Espetos de Pão Sobrados'),
                      SizedBox(height: 10),
                      TextField(
                        controller: _totalArrecadadoController,
                        decoration: InputDecoration(
                          labelText: 'Total Arrecadado',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        enabled: false,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _atualizarRegistro,
                        child: Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[800], // Cor de fundo do TextField
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        // Estilizando o texto dentro do TextField
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
    );
  }
}
