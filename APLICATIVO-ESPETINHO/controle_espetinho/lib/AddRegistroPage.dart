import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa o pacote intl para formatação de data
import 'controller/Controllers.dart';

class AddRegistroPage extends StatefulWidget {
  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {
  TextEditingController _dataController = TextEditingController(); // Controlador para o campo de data

  @override
  void initState() {
    super.initState();
    _dataController.text = _formatDate(DateTime.now()); // Define a data atual no controlador de texto ao abrir a página
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
                final data = _dataController.text;
                final levadosCarne = _parseTextFieldToInt(PageControllers.levadosCarneController);
                final levadosLinguica = _parseTextFieldToInt(PageControllers.levadosLinguicaController);
                final levadosLinguicaApimentada = _parseTextFieldToInt(PageControllers.levadosLinguicaApimentadaController);
                final levadosFrango = _parseTextFieldToInt(PageControllers.levadosFrangoController);
                final levadosPernil = _parseTextFieldToInt(PageControllers.levadosPernilController);
                final levadosCoracao = _parseTextFieldToInt(PageControllers.levadosCoracaoController);
                final levadosQueijo = _parseTextFieldToInt(PageControllers.levadosQueijoController);
                final levadosPao = _parseTextFieldToInt(PageControllers.levadosPaoController);
                final sobrouCarne = _parseTextFieldToInt(PageControllers.sobrouCarneController);
                final sobrouLinguica = _parseTextFieldToInt(PageControllers.sobrouLinguicaController);
                final sobrouLinguicaApimentada = _parseTextFieldToInt(PageControllers.sobrouLinguicaApimentadaController);
                final sobrouFrango = _parseTextFieldToInt(PageControllers.sobrouFrangoController);
                final sobrouPernil = _parseTextFieldToInt(PageControllers.sobrouPernilController);
                final sobrouCoracao = _parseTextFieldToInt(PageControllers.sobrouCoracaoController);
                final sobrouQueijo = _parseTextFieldToInt(PageControllers.sobrouQueijoController);
                final sobrouPao = _parseTextFieldToInt(PageControllers.sobrouPaoController);

                await _adicionarRegistro(
                  data,
                  levadosCarne,
                  levadosLinguica,
                  levadosLinguicaApimentada,
                  levadosFrango,
                  levadosPernil,
                  levadosCoracao,
                  levadosQueijo,
                  levadosPao,
                  sobrouCarne,
                  sobrouLinguica,
                  sobrouLinguicaApimentada,
                  sobrouFrango,
                  sobrouPernil,
                  sobrouCoracao,
                  sobrouQueijo,
                  sobrouPao,
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
    int levadosCarne,
    int levadosLinguica,
    int levadosLinguicaApimentada,
    int levadosFrango,
    int levadosPernil,
    int levadosCoracao,
    int levadosQueijo,
    int levadosPao,
    int sobrouCarne,
    int sobrouLinguica,
    int sobrouLinguicaApimentada,
    int sobrouFrango,
    int sobrouPernil,
    int sobrouCoracao,
    int sobrouQueijo,
    int sobrouPao,
  ) async {
    try {
      await PageControllers.database.push().set({
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
      });
      print('Registro adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar registro: $e');
    }
  }
}
