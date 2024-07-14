import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'controller/ControllerRegistroDiario.dart';
import 'calculos/CalcularTotalArrecadado.dart';

class EditRegistroPage extends StatefulWidget {
  final RegistroDiario registroEdit; 

  EditRegistroPage({required this.registroEdit});

  @override
  _EditRegistroPageState createState() => _EditRegistroPageState();
}

class _EditRegistroPageState extends State<EditRegistroPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('registrosDiarios');
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _levadosCarneController = TextEditingController();
  final TextEditingController _levadosLinguicaController = TextEditingController();
  final TextEditingController _levadosLinguicaApimentadaController = TextEditingController();
  final TextEditingController _levadosFrangoController = TextEditingController();
  final TextEditingController _levadosPernilController = TextEditingController();
  final TextEditingController _levadosCoracaoController = TextEditingController();
  final TextEditingController _levadosQueijoController = TextEditingController();
  final TextEditingController _levadosPaoController = TextEditingController();
  final TextEditingController _sobrouCarneController = TextEditingController();
  final TextEditingController _sobrouLinguicaController = TextEditingController();
  final TextEditingController _sobrouLinguicaApimentadaController = TextEditingController();
  final TextEditingController _sobrouFrangoController = TextEditingController();
  final TextEditingController _sobrouPernilController = TextEditingController();
  final TextEditingController _sobrouCoracaoController = TextEditingController();
  final TextEditingController _sobrouQueijoController = TextEditingController();
  final TextEditingController _sobrouPaoController = TextEditingController();
  final TextEditingController _totalArrecadadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataController.text = widget.registroEdit.data;
    _levadosCarneController.text = widget.registroEdit.levados['carne'].toString();
    _levadosLinguicaController.text = widget.registroEdit.levados['linguica'].toString();
    _levadosLinguicaApimentadaController.text = widget.registroEdit.levados['linguicaApimentada'].toString();
    _levadosFrangoController.text = widget.registroEdit.levados['frango'].toString();
    _levadosPernilController.text = widget.registroEdit.levados['pernil'].toString();
    _levadosCoracaoController.text = widget.registroEdit.levados['coracao'].toString();
    _levadosQueijoController.text = widget.registroEdit.levados['queijo'].toString();
    _levadosPaoController.text = widget.registroEdit.levados['pao'].toString();
    _sobrouCarneController.text = widget.registroEdit.sobrou['carne'].toString();
    _sobrouLinguicaController.text = widget.registroEdit.sobrou['linguica'].toString();
    _sobrouLinguicaApimentadaController.text = widget.registroEdit.sobrou['linguicaApimentada'].toString(); 
    _sobrouFrangoController.text = widget.registroEdit.sobrou['frango'].toString();
    _sobrouPernilController.text = widget.registroEdit.sobrou['pernil'].toString();
    _sobrouCoracaoController.text = widget.registroEdit.sobrou['coracao'].toString();
    _sobrouQueijoController.text = widget.registroEdit.sobrou['queijo'].toString();
    _sobrouPaoController.text = widget.registroEdit.sobrou['pao'].toString();

    
    double totalArrecadado = calcularTotalArrecadado(
      widget.registroEdit.levados,
      widget.registroEdit.sobrou,
    );
    
    _totalArrecadadoController.text = totalArrecadado.toString();
  }

  void _atualizarRegistro() {
    
    final data = _dataController.text;
    final levadosCarne = int.tryParse(_levadosCarneController.text) ?? 0;
    final levadosLinguica = int.tryParse(_levadosLinguicaController.text) ?? 0;
    final levadosLinguicaApimentada = int.tryParse(_levadosLinguicaApimentadaController.text) ?? 0;
    final levadosFrango = int.tryParse(_levadosFrangoController.text) ?? 0;
    final levadosPernil = int.tryParse(_levadosPernilController.text) ?? 0;
    final levadosCoracao = int.tryParse(_levadosCoracaoController.text) ?? 0;
    final levadosQueijo = int.tryParse(_levadosQueijoController.text) ?? 0;
    final levadosPao = int.tryParse(_levadosPaoController.text) ?? 0;
    final sobrouCarne = int.tryParse(_sobrouCarneController.text) ?? 0;
    final sobrouLinguica = int.tryParse(_sobrouLinguicaController.text) ?? 0;
    final sobrouLinguicaApimentada = int.tryParse(_sobrouLinguicaApimentadaController.text) ?? 0;
    final sobrouFrango = int.tryParse(_sobrouFrangoController.text) ?? 0;
    final sobrouPernil = int.tryParse(_sobrouPernilController.text) ?? 0;
    final sobrouCoracao = int.tryParse(_sobrouCoracaoController.text) ?? 0;
    final sobrouQueijo = int.tryParse(_sobrouQueijoController.text) ?? 0;
    final sobrouPao = int.tryParse(_sobrouPaoController.text) ?? 0;
    final totalArrecadado = double.tryParse(_totalArrecadadoController.text) ?? 0.0;

    
    widget.registroEdit.data = data;
    widget.registroEdit.levados['carne'] = levadosCarne;
    widget.registroEdit.levados['linguica'] = levadosLinguica;
    widget.registroEdit.levados['linguicaApimentada'] = levadosLinguicaApimentada;
    widget.registroEdit.levados['frango'] = levadosFrango;
    widget.registroEdit.levados['pernil'] = levadosPernil;
    widget.registroEdit.levados['coracao'] = levadosCoracao;
    widget.registroEdit.levados['queijo'] = levadosQueijo;
    widget.registroEdit.levados['pao'] = levadosPao;
    widget.registroEdit.sobrou['carne'] = sobrouCarne;
    widget.registroEdit.sobrou['linguica'] = sobrouLinguica;
    widget.registroEdit.sobrou['linguicaApimentada'] = sobrouLinguicaApimentada;
    widget.registroEdit.sobrou['frango'] = sobrouFrango;
    widget.registroEdit.sobrou['pernil'] = sobrouPernil;
    widget.registroEdit.sobrou['coracao'] = sobrouCoracao;
    widget.registroEdit.sobrou['queijo'] = sobrouQueijo;
    widget.registroEdit.sobrou['pao'] = sobrouPao;
    widget.registroEdit.totalArrecadado = totalArrecadado;

    
    _database.child(widget.registroEdit.id).update({
      'data': data,
      'levados': {
        'carne': levadosCarne,
        'linguica': levadosLinguica,
        'linguicaApimentada': levadosLinguicaApimentada,
        'frango': levadosFrango,
        'pernil': levadosPernil,
        'coracao': levadosCoracao,
        'queijo': levadosQueijo,
        'pao': levadosPao,
      },
      'sobrou': {
        'carne': sobrouCarne,
        'linguica': sobrouLinguica,
        'linguicaApimentada': sobrouLinguicaApimentada,
        'frango': sobrouFrango,
        'pernil': sobrouPernil,
        'coracao': sobrouCoracao,
        'queijo': sobrouQueijo,
        'pao': sobrouPao,
      },
      'totalArrecadado': totalArrecadado,
    });

    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                controller: _levadosLinguicaApimentadaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Apimentada Levados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _levadosFrangoController,
                decoration: InputDecoration(labelText: 'Espetos de Frango Levados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _levadosPernilController,
                decoration: InputDecoration(labelText: 'Espetos de Pernil Levados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _levadosCoracaoController,
                decoration: InputDecoration(labelText: 'Espetos de Coração Levados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _levadosQueijoController,
                decoration: InputDecoration(labelText: 'Espetos de Queijo Levados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _levadosPaoController,
                decoration: InputDecoration(labelText: 'Espetos de Pão Levados'),
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
              TextField(
                controller: _sobrouLinguicaApimentadaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Apimentada Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sobrouFrangoController,
                decoration: InputDecoration(labelText: 'Espetos de Frango Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sobrouPernilController,
                decoration: InputDecoration(labelText: 'Espetos de Pernil Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sobrouCoracaoController,
                decoration: InputDecoration(labelText: 'Espetos de Coração Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sobrouQueijoController,
                decoration: InputDecoration(labelText: 'Espetos de Queijo Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sobrouPaoController,
                decoration: InputDecoration(labelText: 'Espetos de Pão Sobrados'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _totalArrecadadoController,
                decoration: InputDecoration(labelText: 'Total Arrecadado'),
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
    );
  }
}
