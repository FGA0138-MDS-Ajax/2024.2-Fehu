import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';


class AtivAndamentoCard extends StatelessWidget {
  final String nomeFuncionario;
  final String nomeDemanda;

  const AtivAndamentoCard({
    super.key,
    required this.nomeFuncionario,
    required this.nomeDemanda,
    });

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          nomeFuncionario,
          style: TextStyle(color: AppColors.blue),
        ),
        subtitle: Text(
          'Em andamento: $nomeDemanda',
          style: TextStyle(
            color: AppColors.blue
          ),
        ),
      ),
    );
  }
}