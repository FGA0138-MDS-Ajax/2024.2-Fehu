import 'dart:math';

import 'package:catavento/bloc/auth/auth_bloc.dart';
import 'package:catavento/bloc/produto/produto_bloc.dart';
import 'package:catavento/bloc/trabalho/trabalho_bloc.dart';
import 'package:catavento/bloc/trabalho/trabalho_controller.dart';
import 'package:catavento/shared/widgets/bloc_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../shared/widgets/menuBar.dart";
import "./components/cardDemandaFuncionario.dart";

final List<Map<String, String>> tasks = [
  {
    "nome": "Tarefa 1",
    "descricao": "Descrição da tarefa 1",
    "codigo": "Código: T1",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 2",
    "descricao": "Descrição da tarefa 2",
    "codigo": "Código: T2",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 3",
    "descricao": "Descrição da tarefa 3",
    "codigo": "Código: T3",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 4",
    "descricao": "Descrição da tarefa 4",
    "codigo": "Código: T4",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 5",
    "descricao": "Descrição da tarefa 5",
    "codigo": "Código: T5",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 6",
    "descricao": "Descrição da tarefa 6",
    "codigo": "Código: T6",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 7",
    "descricao": "Descrição da tarefa 7",
    "codigo": "Código: T7",
    "foto": "https://via.placeholder.com/150"
  },
  {
    "nome": "Tarefa 8",
    "descricao": "Descrição da tarefa 8",
    "codigo": "Código: T8",
    "foto": "https://via.placeholder.com/150"
  },
];

class DashBoardFuncionario extends StatefulWidget {
  const DashBoardFuncionario({super.key});

  @override
  _DashBoardFuncionarioState createState() => _DashBoardFuncionarioState();
}

class _DashBoardFuncionarioState extends State<DashBoardFuncionario> {
  late TrabalhoController _trabalhoController;

  @override
  initState() {
    super.initState();
    _trabalhoController.initialize();
  }

  @override
  dispose() {
    _trabalhoController.finalize();
    super.dispose();
  }

  List<Map<String, dynamic>> demandas = [];
  final List<Map<String, dynamic>> _demandasFalsas = [
    {
      "nome_demanda": "Carregando",
      "produto_id": "Carregando",
      "descricao": "Carregando",
      "status_aplique": 0,
      "status_cobertura": 0,
      "status_montagem": 0,
    },
    {
      "nome_demanda": "Carregando",
      "produto_id": "Carregando",
      "descricao": "Carregando",
      "status_aplique": 0,
      "status_cobertura": 0,
      "status_montagem": 0,
    },
    {
      "nome_demanda": "Carregando",
      "produto_id": "Carregando",
      "descricao": "Carregando",
      "status_aplique": 0,
      "status_cobertura": 0,
      "status_montagem": 0,
    },
    {
      "nome_demanda": "Carregando",
      "produto_id": "Carregando",
      "descricao": "Carregando",
      "status_aplique": 0,
      "status_cobertura": 0,
      "status_montagem": 0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.transparent,
            child: Navbar(),
          ),
          Expanded(
            child: BlocConsumer<TrabalhoBloc, TrabalhoState>(
              listener: (context, state) {
                if (demandas.isEmpty) {
                  final email = context.read<AuthBloc>().email;
                  final setor = context.read<AuthBloc>().setor;
                  context.read<TrabalhoBloc>().add(TrabalhoLoading(
                        email: email!,
                        setor: setor!.toLowerCase(),
                      ));
                }
                if (state is TrabalhoErrorState) {
                  showBlocSnackbar(context, state.message);
                } else if (state is TrabalhoFinishState) {
                  final email = context.read<AuthBloc>().email;
                  final setor = context.read<AuthBloc>().setor!.toLowerCase();
                  context.read<TrabalhoBloc>().add(TrabalhoGet(
                        email: email!,
                        setor: setor,
                      ));
                }
              },
              builder: (context, state) {
                if (state is TrabalhoGetState ||
                    state is TrabalhoLoadingState) {
                  final metaData = state.metaData;
                  final faltam = min(metaData["faltam"] ?? 0, 5);

                  if (state.demandas.isNotEmpty) {
                    demandas.insert(0, state.demandas.first);
                    if (demandas.length < faltam) {
                      demandas.addAll(
                          _demandasFalsas.take(faltam - demandas.length));
                    }
                  }
                }

                final setor = context.read<AuthBloc>().setor!.toLowerCase();
                List<String?> imagens = [];
                for (var demanda in demandas) {
                  final imagem = context
                      .read<ProdutoBloc>()
                      .getImageUrl(demanda['produto_id']);
                  imagens.add(imagem);
                }
                return Center(
                  child: demandas.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth / 5, vertical: 50),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: demandas
                                  .take(5)
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    int index = entry.key;
                                    Map<String, dynamic> task = entry.value;

                                    return AnimatedPositioned(
                                      duration: Duration(milliseconds: 500),
                                      top: index * 20.0,
                                      left: index * 20.0,
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 300),
                                        opacity: 1,
                                        child: Transform.scale(
                                          scale: 1 - (index * 0.05),
                                          child: CardDemanda(
                                            title: task["nome_demanda"]!,
                                            width: screenWidth * 0.27,
                                            height: screenHeight * 0.8,
                                            description: task["descricao"]!,
                                            codigo: task["produto_id"] ??
                                                "Sem código",
                                            imagem: imagens[index],
                                            status: task["status_$setor"] ?? 0,
                                            backgroundColor: Color.lerp(
                                                  const Color.fromARGB(
                                                      255, 235, 235, 235),
                                                  const Color.fromARGB(
                                                      255, 168, 168, 168),
                                                  index / 5,
                                                ) ??
                                                const Color.fromARGB(
                                                    255, 235, 235, 235),
                                            shadowColor: Colors.black
                                                .withOpacity(0.2 + index * 0.1),
                                            onCronometroFinalizado: () {
                                              demandas.removeAt(index);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList()
                                  .reversed
                                  .toList(),
                            ),
                          ),
                        )
                      : Text(
                          "Todas as tarefas foram concluídas!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
