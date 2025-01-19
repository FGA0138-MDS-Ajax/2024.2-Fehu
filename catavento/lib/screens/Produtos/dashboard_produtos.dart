import 'package:catavento/screens/Produtos/components/produtosCard.dart';
import 'package:catavento/screens/Produtos/components/searchProducts.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'package:catavento/shared/widgets/background.dart';
import 'package:catavento/shared/widgets/dialog.dart';
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/input.dart';
import 'package:catavento/shared/widgets/inputs.dart';
import 'package:catavento/shared/widgets/menu.dart';

import 'package:catavento/bloc/demanda/demanda_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardProdutos extends StatelessWidget {
  final List<Map<String, String>> produtos = [
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
    {
      'nomeProduto': '{nomeProduto}',
      'imagem': "../catavento/assets/images/cake.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(title: "Produtos", historyButton: false),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundPage(backgroundColor: Colors.white, children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.18),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Searchproducts(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: _buildBlockListProdutos(context)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      _buildButtonAdicionar(context),
                    ],
                  ),
                ),
              ),
            )
          ])
        ],
      ),
    );
  }

  Widget _buildBlockListProdutos(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.6;
    final double width = MediaQuery.of(context).size.width * 0.8;

    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(left: 65, right: 65),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.blue)),
          child: _buildListProdutos(context),
        )
      ],
    );
  }

  Widget _buildListProdutos(BuildContext context) {
    final DemandaBloc bloc = DemandaBloc();
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, //numero de cards por linha
          crossAxisSpacing: 25, //espaçamento horizontal
          mainAxisSpacing: 55, //espaçamento vertical
          childAspectRatio: 0.8, //Proporção entre largura e altura
        ),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return ProdutosCard(
            nomeProduto: produto['nomeProduto']!,
            image: produto['imagem']!,
            bloc: bloc,
            codigoProduto: '123',
            descricaoProduto: 'Descicao 123',
          );
        });
  }

  Widget _buildButtonAdicionar(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: () {
          _showAdicionarDialog(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gradientDarkBlue,
      
          ),
          child: const Text(
            "Adicionar Demanda",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  }

  void _showAdicionarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableDialog(
          title: "Novo Produto",
          confirmBeforeClose: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  color: AppColors.gradientDarkBlue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Informações Gerais",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FredokaOne',
                                    color: AppColors.gradientDarkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Inputs(text: 'Códigos',),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                            Inputs(text: 'Nome',),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Adicionar Imagem",
                                  style: TextStyle(
                                      color: AppColors.gradientDarkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.camera_alt,
                                    size: 40,
                                    color: AppColors.gradientDarkBlue),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(16), // Bordas arredondadas
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  color: AppColors.gradientDarkBlue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Informações Adicionais",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FredokaOne',
                                    color: AppColors.gradientDarkBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InputTextField(
                                    hintText: "Descrição",
                                    labelText: 'Descrição',
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
