import 'package:flutter/material.dart';

class HistoricoIMC extends StatelessWidget {
  final List<List<double>> historicoIMC;

  const HistoricoIMC({super.key, required this.historicoIMC});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de IMC'),
      ),
      body: ListView.builder(
        itemCount: historicoIMC.length,
        itemBuilder: (context, index) {
          List<double> registro = historicoIMC[index];
          double peso = registro[0];
          double altura = registro[1];
          double imc = registro[2];

          return ListTile(
            title: Text('Peso: ${peso.toStringAsFixed(2)} kg'),
            subtitle: Text('Altura: ${altura.toStringAsFixed(2)} m'),
            trailing: Text('IMC: ${imc.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
