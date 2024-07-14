import 'package:flutter/material.dart';
import 'controller/Controllers.dart';

class AddRegistroPage extends StatefulWidget {
  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {
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
            _buildTextField('Data (YYYY-MM-DD)', PageControllers.dataController),

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
                final data = PageControllers.dataController.text;
                final levadosCarne = int.parse(PageControllers.levadosCarneController.text);
                final levadosLinguica = int.parse(PageControllers.levadosLinguicaController.text);
                final levadosLinguicaApimentada = int.parse(PageControllers.levadosLinguicaApimentadaController.text);
                final levadosFrango = int.parse(PageControllers.levadosFrangoController.text);
                final levadosPernil = int.parse(PageControllers.levadosPernilController.text);
                final levadosCoracao = int.parse(PageControllers.levadosCoracaoController.text);
                final levadosQueijo = int.parse(PageControllers.levadosQueijoController.text);
                final levadosPao = int.parse(PageControllers.levadosPaoController.text);
                final sobrouCarne = int.parse(PageControllers.sobrouCarneController.text);
                final sobrouLinguica = int.parse(PageControllers.sobrouLinguicaController.text);
                final sobrouLinguicaApimentada = int.parse(PageControllers.sobrouLinguicaApimentadaController.text);
                final sobrouFrango = int.parse(PageControllers.sobrouFrangoController.text);
                final sobrouPernil = int.parse(PageControllers.sobrouPernilController.text);
                final sobrouCoracao = int.parse(PageControllers.sobrouCoracaoController.text);
                final sobrouQueijo = int.parse(PageControllers.sobrouQueijoController.text);
                final sobrouPao = int.parse(PageControllers.sobrouPaoController.text);

                await _adicionarRegistro(data, levadosCarne, levadosLinguica, levadosLinguicaApimentada, levadosFrango, levadosPernil, levadosCoracao, levadosQueijo, levadosPao, sobrouCarne, sobrouLinguica, sobrouLinguicaApimentada, sobrouFrango, sobrouPernil, sobrouCoracao, sobrouQueijo, sobrouPao);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
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
      ),
    );
  }

  Future<void> _adicionarRegistro(String data, int levadosCarne, int levadosLinguica, int levadosLinguicaApimentada, int levadosFrango, int levadosPernil, int levadosCoracao, int levadosQueijo, int levadosPao, int sobrouCarne, int sobrouLinguica, int sobrouLinguicaApimentada, int sobrouFrango, int sobrouPernil, int sobrouCoracao, int sobrouQueijo, int sobrouPao ) async {
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
