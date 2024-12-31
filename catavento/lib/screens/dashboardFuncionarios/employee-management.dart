import 'package:catavento/bloc/usuario/usuario_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/ativAndamentoCard.dart';
import 'package:catavento/shared/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:catavento/shared/widgets/background.dart';
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/blocks.dart';
import 'package:catavento/shared/widgets/showDialog.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'components/funcionarioCard.dart';

class EmployeeManagement extends StatelessWidget {
  final List<Map<String, String>> ativAndamento = [
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
  ];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF015C98),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20), // Padding aqui
              child: Material(
                color: Colors.transparent, // Mantém o fundo transparente
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // Abre o Drawer
                  },
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 20), // Ajuste o valor conforme necessário
            child: TextButton.icon(
              icon: const Icon(Icons.history, size: 18.0),
              label: const Text("Ver Histórico"),
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF015C98),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundPage(
        gradientColors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)],
        children: [
          CustomHeader(title: "Funcionários"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Blocks(     Precisa do backend para funcionar.
                    color: Colors.white,
                    height: 97,
                    width: 321,
                    borderRadius: 26,
                    child: 
                      Graficinfo<UsuarioBloc, UsuarioState>(
                        size: 50,
                        icons: Icons.group_add,
                        colorIcons: Color(0xFF015C98), 
                        info: 'Funcionários', 
                        dataKey: 'total', 
                        buildWhen: (previous, current) => previous.metaData != current.metaData,
                        )
                  ),*/

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  /*Blocks(        Precisa do backend para funcionar
                    color: Colors.white,
                    height: 97,
                    width: 321,
                    borderRadius: 26,
                    child: 
                      Graficinfo<UsuarioBloc, UsuarioState>(
                        size: 50,
                        icons: Icons.verified,
                        colorIcons: Colors.green, 
                        info: 'Funcionários presentes', 
                        dataKey: 'funcionarios', 
                        buildWhen: (previous, current) => previous.metaData != current.metaData,
                        )
                  ),*/

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        //Logica do botão
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Showdialog(
                              width: 463,
                              height: 402,
                              title: 'Novo funcionário',
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Inputs(
                                      text: "Nome:",
                                      hint: "Nome do funcionário",
                                      controller: _nomeController,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Inputs(
                                      text: "Setor:",
                                      hint: "Setor do funcionário",
                                      controller: _setorController,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Inputs(
                                      text: "Email:",
                                      hint: "Email do funcionário",
                                      controller: _emailController,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Inputs(
                                      text: "Nome de usuário:",
                                      hint: "Nome de usuário do funcionário",
                                      controller: _usuarioController,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Inputs(
                                      text: "Senha:",
                                      hint: "Senha para o funcionário",
                                      controller: _senhaController,
                                    ),
                                    Inputs(
                                      text: "Confirmar senha:",
                                      hint: "Confirme a senha para o funcionário",
                                      controller: _senhaController,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08),
                                    Positioned.fill(
                                        child: Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<UsuarioBloc>()
                                                      .add(UsuarioCreate(
                                                        _nomeController.text,
                                                        _usuarioController.text,
                                                        _setorController.text,
                                                        _emailController.text,
                                                        'padrao',
                                                        _senhaController.text,
                                                      ));
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22))),
                                                child: Text(
                                                  "Cadastrar",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))))
                                  ]),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF015C98),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                      ),
                      child: Text(
                        "Cadastrar funcionário",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.height * 0.07),
              Blocks(
                  title: "Todos os funcionários",
                  color: Colors.white,
                  borderRadius: 26,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.height * 0.45,
                      child: BlocBuilder<UsuarioBloc, UsuarioState>(
                        builder: (context, state) {
                          final funcionarios = state.databaseResponse;
                          return ListView.builder(
                            //Aqui vai o cards dos funcionarios cadastrados
                            itemCount: funcionarios.length,
                            itemBuilder: (context, index) {
                              final funcionario = funcionarios[index];
                              return FuncionarioCard(
                                nomeFuncionario:
                                    funcionario['usuario'] ?? "Indisponível",
                                setor: funcionario['setor'] ?? "Indisponível",
                                status: funcionario['status'] ?? "Indisponível",
                                email: funcionario['email'] ?? "Indisponível",
                              );
                            },
                          );
                        },
                      ))),
              SizedBox(width: MediaQuery.of(context).size.height * 0.07),
              Blocks(
                  title: "Atividades em andamento",
                  color: Colors.white,
                  borderRadius: 26,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Center(
                          child: Text(
                            "Setor de Cobertura",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            //Aqui vai o card das atividades em andamento (Corte)
                            itemCount: ativAndamento.length,
                            itemBuilder: (context, index) {
                              final atividade = ativAndamento[index];
                              return AtivAndamentoCard(
                                nomeFuncionario: atividade['nome']!,
                                nomeDemanda: atividade['demanda']!,
                              );
                            },
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Center(
                        child: Text(
                          "Setor de Aplique",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            //Aqui vai os cards das atividades em andamento (Montagem)
                            itemCount: ativAndamento.length,
                            itemBuilder: (context, index) {
                              final atividade = ativAndamento[index];
                              return AtivAndamentoCard(
                                nomeFuncionario: atividade['nome']!,
                                nomeDemanda: atividade['demanda']!,
                              );
                            },
                          )),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
