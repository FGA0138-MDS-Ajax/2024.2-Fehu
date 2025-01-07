import 'dart:io';

import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';


class Bolosdesempenhocard extends StatefulWidget{
  final String nomeDemanda;
  final String inicio;
  final String fim;
  final String duracao;
  final String image;

  const Bolosdesempenhocard({
    super.key,
    required this.nomeDemanda,
    required this.inicio,
    required this.fim,
    required this.duracao,
    required this.image,
  });

  @override
  State<Bolosdesempenhocard> createState() {
    return BolosdesempenhocardState();
  }
}

class BolosdesempenhocardState extends State<Bolosdesempenhocard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.height * 0.03,),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.05,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                File (widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.08,),
          Column(
            children: [
              Center(
                child: Text(
                  widget.nomeDemanda,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Row(
                children: [
                  Info(texto: 'Inicio: ', info: widget.inicio),
                  SizedBox(width: MediaQuery.of(context).size.height * 0.02,),
                  Info(texto: 'Fim: ', info: widget.fim)
                ],
              ),
              Info(texto: 'Duração: ', info: widget.duracao),
            ],
          )
        ],
      ),
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
            fontSize: 14,
            color: AppColors.blue,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          info,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.blue,
          )
        )
      ],
    );
  }
}