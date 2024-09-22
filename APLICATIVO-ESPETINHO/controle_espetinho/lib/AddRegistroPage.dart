import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa o pacote intl para formatação de data
import '../controller/Controllers.dart';
import '../controller/ControllerPrecos.dart'; // Importa o controlador de preços
import 'Calculos/CalcularTotalArrecadado.dart';

class AddRegistroPage extends StatefulWidget {
  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {
  TextEditingController _dataController = TextEditingController(); // Controlador para o campo de data

  @override
  void initState() {
    super.initState();
    _limparCampos(); // Limpar os campos ao iniciar a tela
  }

  void _limparCampos() {
    // Limpar todos os controladores de texto
    _dataController.text = _formatDate(DateTime.now()); // Define a data atual no controlador de texto ao abrir a página
    PageControllers.levadosCarneController.text = '';
    PageControllers.levadosLinguicaController.text = '';
    PageControllers.levadosLinguicaApimentadaController.text = '';
    PageControllers.levadosFrangoController.text = '';
    PageControllers.levadosPernilController.text = '';
    PageControllers.levadosCoracaoController.text = '';
    PageControllers.levadosQueijoController.text = '';
    PageControllers.levadosPaoController.text = '';
    PageControllers.sobrouCarneController.text = '';
    PageControllers.sobrouLinguicaController.text = '';
    PageControllers.sobrouLinguicaApimentadaController.text = '';
    PageControllers.sobrouFrangoController.text = '';
    PageControllers.sobrouPernilController.text = '';
    PageControllers.sobrouCoracaoController.text = '';
    PageControllers.sobrouQueijoController.text = '';
    PageControllers.sobrouPaoController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Registro Diário',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.grey[900], // Cor de fundo da AppBar
        elevation: 0, // Remove a sombra da AppBar
        iconTheme: IconThemeData(color: Colors.white), // Cor da seta de voltar
      ),
      backgroundColor: Colors.grey[900], // Cor de fundo do Scaffold

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16), // Espaço antes do primeiro TextField

            // TextField para Data
            _buildTextField('Data (YYYY-MM-DD)', _dataController),

            SizedBox(height: 16), // Espaço entre os TextFields

            // Agrupamento de Espetos Levados
            _buildEspetosGroup('Espetos Levados', [
              _buildEspetoTextField('Carne Levados', PageControllers.levadosCarneController),
              _buildEspetoTextField('Linguiça Levados', PageControllers.levadosLinguicaController),
              _buildEspetoTextField('Linguiça Apimentada Levados', PageControllers.levadosLinguicaApimentadaController),
              _buildEspetoTextField('Frango Levados', PageControllers.levadosFrangoController),
              _buildEspetoTextField('Pernil Levados', PageControllers.levadosPernilController),
              _buildEspetoTextField('Coração Levados', PageControllers.levadosCoracaoController),
              _buildEspetoTextField('Queijo Levados', PageControllers.levadosQueijoController),
              _buildEspetoTextField('Pão Levados', PageControllers.levadosPaoController),
            ]),

            SizedBox(height: 16), // Espaço entre os grupos de TextFields

            // Agrupamento de Espetos Sobrados
            _buildEspetosGroup('Espetos Sobrados', [
              _buildEspetoTextField('Carne Sobrados', PageControllers.sobrouCarneController),
              _buildEspetoTextField('Linguiça Sobrados', PageControllers.sobrouLinguicaController),
              _buildEspetoTextField('Linguiça Apimentada Sobrados', PageControllers.sobrouLinguicaApimentadaController),
              _buildEspetoTextField('Frango Sobrados', PageControllers.sobrouFrangoController),
              _buildEspetoTextField('Pernil Sobrados', PageControllers.sobrouPernilController),
              _buildEspetoTextField('Coração Sobrados', PageControllers.sobrouCoracaoController),
              _buildEspetoTextField('Queijo Sobrados', PageControllers.sobrouQueijoController),
              _buildEspetoTextField('Pão Sobrados', PageControllers.sobrouPaoController),
            ]),

            SizedBox(height: 20), // Espaço abaixo dos TextFields

            // Botão de Salvar
            ElevatedButton(
              onPressed: () async {
                var data = _dataController.text;
                var levados = {
                  'carne': _parseTextFieldToInt(PageControllers.levadosCarneController),
                  'linguica': _parseTextFieldToInt(PageControllers.levadosLinguicaController),
                  'linguicaApimentada': _parseTextFieldToInt(PageControllers.levadosLinguicaApimentadaController),
                  'frango': _parseTextFieldToInt(PageControllers.levadosFrangoController),
                  'pernil': _parseTextFieldToInt(PageControllers.levadosPernilController),
                  'coracao': _parseTextFieldToInt(PageControllers.levadosCoracaoController),
                  'queijo': _parseTextFieldToInt(PageControllers.levadosQueijoController),
                  'pao': _parseTextFieldToInt(PageControllers.levadosPaoController),
                };
                var sobrou = {
                  'carne': _parseTextFieldToInt(PageControllers.sobrouCarneController),
                  'linguica': _parseTextFieldToInt(PageControllers.sobrouLinguicaController),
                  'linguicaApimentada': _parseTextFieldToInt(PageControllers.sobrouLinguicaApimentadaController),
                  'frango': _parseTextFieldToInt(PageControllers.sobrouFrangoController),
                  'pernil': _parseTextFieldToInt(PageControllers.sobrouPernilController),
                  'coracao': _parseTextFieldToInt(PageControllers.sobrouCoracaoController),
                  'queijo': _parseTextFieldToInt(PageControllers.sobrouQueijoController),
                  'pao': _parseTextFieldToInt(PageControllers.sobrouPaoController),
                };

                var totalArrecadado = calcularTotalArrecadado(levados, sobrou);

                await _adicionarRegistro(
                  data,
                  levados,
                  sobrou,
                  totalArrecadado,
                );
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime); // Formata a data no formato desejado
  }

  int _parseTextFieldToInt(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) {
      return 0; // Valor padrão se o campo estiver vazio
    }
    try {
      return int.parse(text);
    } catch (e) {
      print('Erro ao converter $text para inteiro: $e');
      return 0; // Valor padrão se a conversão falhar
    }
  }

  Widget _buildEspetosGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildEspetoTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
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
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
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
      ),
    );
  }

  Future<void> _adicionarRegistro(
    String data,
    Map<String, int> levados,
    Map<String, int> sobrou,
    double totalArrecadado,
  ) async {
    try {
      await PageControllers.database.push().set({
        'data': data,
        'levados': levados,
        'sobrou': sobrou,
        'totalArrecadado': totalArrecadado,
      });
      print('Registro adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar registro: $e');
    }
  }
}
