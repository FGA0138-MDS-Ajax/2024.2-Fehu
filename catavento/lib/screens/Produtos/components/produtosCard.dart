import 'dart:io';

import 'package:catavento/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:catavento/shared/widgets/dialog.dart';

class ProdutosCard extends StatefulWidget {
  final String nomeProduto;
  final String image;

  // final ProdutoBloc bloc; ---- COLOCAR O BLOC AQUI DEPOIS

  const ProdutosCard(
      {super.key,
      required this.nomeProduto,
      // required this.bloc,    ------ após colocar o bloc, descomentar aqui
      required this.image});

  @override
  State<ProdutosCard> createState() {
    return ProdutosCardState();
  }
}

class ProdutosCardState extends State<ProdutosCard> {
  /*
  final TextEditingController nomeController =
      TextEditingController(text: nome);
  final TextEditingController codigoController =
      TextEditingController(text: codigo);
  final TextEditingController descricaoController =
      TextEditingController(text: descricao);*/ // descomentar aqui tbm

  // dados estáticos temporários
  final String nome = "Bolo Exemplo";
  final String codigo = "CODIGO123";
  final String descricao = "Descrição do produto (Bolo Exemplo) aqui.";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 17, top: 17),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: AppColors.lightGray)),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Image.file(
                  File(widget.image),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.01,
            color: AppColors.lightPink,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Text(
                    widget.nomeProduto,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButtonEditar(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    _buildButtonInfo(context)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonEditar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.066,
      child: ElevatedButton(
        onPressed: () {
          // _showEditDialog(context, nome, codigo, descricao);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(
          "Editar",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildButtonInfo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.066,
      child: ElevatedButton(
        onPressed: () {
          _showInfoDialog(context, nome, codigo, descricao,
              "https://via.placeholder.com/150");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Text(
          "Info",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  // Função para mostrar as informações da demanda em um diálogo
  void _showInfoDialog(BuildContext context, String nome, String codigo,
      String descricao, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableDialog(
          backgroundColor: AppColors.lightGray,
          title: nome,
          body: SingleChildScrollView(
            // Adicionando SingleChildScrollView para evitar overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem com altura e largura definidas
                Container(
                  width: double
                      .infinity, // A imagem ocupará toda a largura disponível
                  height:
                      150, // Altura fixada para evitar que a imagem ocupe um tamanho indefinido
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/photo.jpg',
                      fit: BoxFit.cover, // Garante que a imagem cubra a área
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Informações adicionais
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16), // Bordas arredondadas
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Código
                      Row(
                        children: [
                          const Text(
                            "Código:",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.bold,
                              color: AppColors.gradientDarkBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              codigo,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Fredoka',
                                color: AppColors.gradientDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Descrição
                      Text(
                        descricao,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gradientDarkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
