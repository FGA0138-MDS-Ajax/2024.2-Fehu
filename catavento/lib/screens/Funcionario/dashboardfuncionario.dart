import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../../shared/widgets/menuBar.dart";
import "./components/cardDemandaFuncionario.dart";
import 'package:catavento/screens/DadosFuncionario/components/widgetDadosFuncionario.dart';

class DashBoardFuncionario extends StatelessWidget {
  const DashBoardFuncionario({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => {
              Scaffold.of(context).openDrawer(),
            },
            icon: Icon(Icons.tune, color: Colors.black),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [CardDemanda(title: "Demanda 1", codigo: "2313421", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet quam vel dolor convallis, vel scelerisque magna vehicula. Vivamus pharetra dui at tortor vehicula, eget maximus metus mollis. Proin sed nulla ac lectus convallis gravida sit amet nec purus. Etiam sit amet vulputate libero. Nulla facilisi. Donec dapibus dui id mi tempor, vel iaculis justo consequat. Suspendisse potenti. Sed dapibus sapien vel massa suscipit, eget volutpat orci fermentum. Nulla facilisi. Ut at egestas en",) ],
      ),
    );
  }
}
