import 'package:catavento/screens/Desempenho/components/filtroSetor.dart';
import 'package:catavento/screens/Desempenho/components/funcionariosCardDesempenho.dart';
import 'package:catavento/screens/Desempenho/components/searchFuncionarios.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'package:catavento/shared/widgets/background.dart';
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'package:flutter/material.dart';

class DashboardDesempenhoAdmin extends StatelessWidget {
  final TextEditingController _setorcontroller = TextEditingController();

  final List<Map<String, String>> funcionarios = [
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},
    {'nomeFuncionario' : 'nomeFuncionario', 'setor' : 'Montagem'},

    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(title: "Desempenho", historyButton: false),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SearchFuncionarios(),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                            Filtrosetor(controller: _setorcontroller)
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: _buildBlockListFuncionarios(context)),
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

  Widget _buildBlockListFuncionarios(BuildContext context) {
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
          child: _buildListFuncionarios(context),
        )
      ],
    );
  }

  Widget _buildListFuncionarios(BuildContext context) {
    
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //numero de cards por linha
        crossAxisSpacing: 35, //espaçamento horizontal
        mainAxisSpacing: 25, //espaçamento vertical
        childAspectRatio: 3.5 //Proporção entre largura e altura
      ),
      itemCount: funcionarios.length,
      itemBuilder: (context, index) {
        final funcionario = funcionarios[index];
        return FuncionariosCardDesempenho(
          nomeFuncionario: funcionario['nomeFuncionario']!, 
          setor: funcionario['setor']!, 
        );
      }
    );
  }

}