import 'package:catavento/screens/Produtos/components/produtosCard.dart';
import 'package:catavento/screens/Produtos/components/searchProducts.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'package:catavento/shared/widgets/background.dart';
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardProdutos extends StatelessWidget {

  final List<Map<String, String >> produtos = [
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
    {'nomeProduto' : '{nomeProduto}', 'imagem' : "../catavento/assets/images/cake.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(
        title: "Produtos", 
        historyButton: false
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundPage(
            backgroundColor: Colors.white,
            children: [
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
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: _buildBlockListProdutos(context)
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]
          )
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
            border: Border.all(color: AppColors.blue)
          ),
          child: _buildListProdutos(context),
        )
      ],
    );
  }

  Widget _buildListProdutos(BuildContext context) {

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,  //numero de cards por linha
        crossAxisSpacing: 25, //espaçamento horizontal
        mainAxisSpacing: 55,  //espaçamento vertical
        childAspectRatio: 0.8,  //Proporção entre largura e altura
      ), 
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        final produto = produtos[index];
        return ProdutosCard(
          nomeProduto: produto['nomeProduto']!,
          image: produto['imagem']!,
        );
      }
    );
  }
}