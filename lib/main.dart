import 'package:flutter/material.dart';
import 'package:imc_flutter/classes/calculo_imc.dart';
import 'package:imc_flutter/pages/page_historico.dart';

void main() {
  runApp(const MeuImc());
}

class MeuImc extends StatelessWidget {
  const MeuImc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = '';
  String classificacao = '';

  List<List<double>> historicoIMC = [];

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0.0;
    double altura = double.tryParse(alturaController.text) ?? 0.0;

    CalculoIMC calculadora = CalculoIMC();
    double imc = calculadora.calcularIMC(peso, altura);
    //var classifica = calculadora.getClassificacao(imc);

    if (peso > 0 && altura > 0) {
      List<double> registroIMC = [peso, altura, imc];
      setState(() {
        resultado = 'Seu IMC é ${imc.toStringAsFixed(2)}';
        classificacao =
            'Sua classificação : ${calculadora.getClassificacao(imc)}';
        historicoIMC.add(registroIMC);
        pesoController.clear();
        alturaController.clear();
      });
    } else {
      setState(() {
        resultado = 'Por favor, insira valores válidos para peso e altura..';
        classificacao = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 16.0),
            Text(
              resultado,
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              classificacao,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (historicoIMC.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoricoIMC(historicoIMC: historicoIMC),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Histórico Vazio'),
                  content: Text('Nenhum registro de IMC no histórico.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.history),
      ),
    );
  }
}
