import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class Infofuncionarios extends StatelessWidget{
  final String nome;
  final String email;
  final String status;
  final String setor;
  final String demanda;

  const Infofuncionarios({
    super.key,
    required this.nome,
    required this.email,
    required this.status,
    required this.setor,
    required this.demanda,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Info(texto: "Nome: ", info: nome),
        Info(texto: "Email: ", info: email),
        Info(texto: "Status: ", info: status),
        Info(texto: "Setor: ", info: setor),
        Info(texto: "Atividade em andamento: ", info: demanda),

      ],
    );
  }
}

class Info extends StatelessWidget {
  final String texto;
  final String info;

  Info({
    required this.texto,
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          texto,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.blue,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.blue,
          )
        )
      ],
    );
  }
}