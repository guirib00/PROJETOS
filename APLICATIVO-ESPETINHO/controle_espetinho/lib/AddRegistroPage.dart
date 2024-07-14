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
        title: Text('Adicionar Registro Diário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: PageControllers.dataController,
                decoration: InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosCarneController,
                decoration: InputDecoration(labelText: 'Espetos de Carne Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosLinguicaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosLinguicaApimentadaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Apimentada Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosFrangoController,
                decoration: InputDecoration(labelText: 'Espetos de Frango Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosPernilController,
                decoration: InputDecoration(labelText: 'Espetos de Pernil Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosCoracaoController,
                decoration: InputDecoration(labelText: 'Espetos de Coração Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosQueijoController,
                decoration: InputDecoration(labelText: 'Espetos de Queijo Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.levadosPaoController,
                decoration: InputDecoration(labelText: 'Espetos de Pão Levados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouCarneController,
                decoration: InputDecoration(labelText: 'Espetos de Carne Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouLinguicaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouLinguicaApimentadaController,
                decoration: InputDecoration(labelText: 'Espetos de Linguiça Apimentada Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouFrangoController,
                decoration: InputDecoration(labelText: 'Espetos de Frango Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouPernilController,
                decoration: InputDecoration(labelText: 'Espetos de Pernil Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouCoracaoController,
                decoration: InputDecoration(labelText: 'Espetos de Coração Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouQueijoController,
                decoration: InputDecoration(labelText: 'Espetos de Queijo Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: PageControllers.sobrouPaoController,
                decoration: InputDecoration(labelText: 'Espetos de Pão Sobrados'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
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
     }catch (e) {
      print('Erro ao adicionar registro: $e');
    // tratamento de erro, se necessário
  }
  }
}
