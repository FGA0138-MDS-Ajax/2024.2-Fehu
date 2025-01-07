import 'package:catavento/screens/dashboardFuncionarios/components/DropDownButton.dart';

import 'package:catavento/bloc/usuario/usuario_bloc.dart';
import 'package:catavento/shared/widgets/inputs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/ativAndamentoCard.dart';
import 'package:catavento/shared/widgets/input.dart';

import 'package:flutter/material.dart';
import 'package:catavento/screens/dashboardFuncionarios/components/checkBox.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'components/funcionarioCard.dart';
import 'package:catavento/shared/widgets/background.dart';
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/blocks.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'package:catavento/shared/widgets/dialog.dart';
import 'package:catavento/shared/widgets/graficInfo.dart';

import 'components/register_button.dart';

class EmployeeManagement extends StatelessWidget {
  final List<Map<String, String>> ativAndamento = [
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
    {'nome': 'nomeFuncionario', 'demanda': 'nomeDemanda'},
  ];

  final List<Map<String, String>> funcionarios = [
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
    {'nome': 'nomeFuncionario', 'setor': 'nomeCargo', 'status': 'Ativo'},
  ];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(
        title: 'Funcionários',
        historyButton: false,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundPage(
            backgroundColor: Colors.white,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWideScreen = constraints.maxWidth > 600;
                    return SingleChildScrollView(
                      child: isWideScreen
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      _buildBlockFunTotal(context),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildBlockFunPresentes(context),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildNewEmployeeButton(context),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Flexible(
                                  flex: 2,
                                  child: _buildFuncionariosBlock(context),
                                ),
                                const SizedBox(width: 20),
                                Flexible(
                                  flex: 3,
                                  child: _buildAtividadesBlock(context),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildNewEmployeeButton(context),
                                const SizedBox(height: 20),
                                _buildFuncionariosBlock(context),
                                const SizedBox(height: 20),
                                _buildAtividadesBlock(context),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewEmployeeButton(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final buttonWidth = size.width * (size.width > 600 ? 0.25 : 0.8);
    final buttonHeight = size.height * 0.06;

    return Center(
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientDarkBlue, AppColors.gradientLightBlue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ElevatedButton(
          onPressed: () {
            _showNewEmployeeDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Text(
            "Novo Funcionário",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlockFunTotal(context) {
    final size = MediaQuery.of(context).size;

    final blockWidth = size.width * (size.width > 600 ? 0.25 : 0.8);
    final blockHeight = size.height * 0.17;

    return Blocks(
      height: blockHeight,
      width: blockWidth,
      color: AppColors.lightGray,
      borderRadius: 26,
      child: Center(
        child: Graficinfo<UsuarioBloc, UsuarioState>(
          size: 40,
          icons: Icons.group_add,
          colorIcons: Color(0xFF015C98),
          info: 'Funcionários',
          dataKey: 'total',
          buildWhen: (previous, current) =>
              previous.metaData != current.metaData,
        ),
      ),
    );
  }

  Widget _buildBlockFunPresentes(context) {
    final size = MediaQuery.of(context).size;

    final blockWidth = size.width * (size.width > 600 ? 0.25 : 0.8);
    final blockHeight = size.height * 0.17;

    return Blocks(
      height: blockHeight,
      width: blockWidth,
      color: AppColors.lightGray,
      borderRadius: 26,
      child: Center(
          child: Graficinfo<UsuarioBloc, UsuarioState>(
        size: 40,
        icons: Icons.verified,
        colorIcons: Colors.green,
        info: 'Funcionários presentes',
        dataKey: 'funcionarios',
        buildWhen: (previous, current) => previous.metaData != current.metaData,
      )),
    );
  }

  Widget _buildFuncionariosBlock(BuildContext context) {
    return Blocks(
        title: "Todos os funcionários",
        titleColor: AppColors.gradientDarkBlue,
        color: AppColors.lightGray,
        borderRadius: 26,
        child: LayoutBuilder(builder: (context, contraints) {
          double height = contraints.maxHeight * 0.85;
          double listWidth = contraints.maxWidth * 0.9;
          return SizedBox(
            width: listWidth,
            height: height,
            child: BlocBuilder<UsuarioBloc, UsuarioState>(
              builder: (context, state) {
                final data = state.databaseResponse;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final funcionario = data[index];
                    return FuncionarioCard(
                      nomeFuncionario: funcionario['usuario'],
                      setor: funcionario['setor'],
                      status: funcionario['status'] ?? "Indisponível",
                      email: funcionario['email'],
                    );
                  },
                );
              },
            ),
          );
        }));
  }

  Widget _buildAtividadesBlock(BuildContext context) {
    return Blocks(
      title: "Atividades em andamento",
      titleColor: AppColors.gradientDarkBlue,
      color: AppColors.lightGray,
      borderRadius: 26,
      child: LayoutBuilder(builder: (context, contraints) {
        double height = contraints.maxHeight * 0.85;
        double listWidth = contraints.maxWidth * 0.9;
        return SizedBox(
          width: listWidth,
          height: height,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              _buildAtividadeSetor("Setor de Cobertura"),
              const SizedBox(height: 20),
              _buildAtividadeSetor("Setor de Aplique"),
              const SizedBox(height: 20),
              _buildAtividadeSetor("Setor de Montagem"),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAtividadeSetor(String setor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          setor,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ativAndamento.length,
          itemBuilder: (context, index) {
            final atividade = ativAndamento[index];
            return AtivAndamentoCard(
              nomeFuncionario: atividade['nome']!,
              nomeDemanda: atividade['demanda']!,
            );
          },
        ),
      ],
    );
  }

  void _showNewEmployeeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: LayoutBuilder(builder: (context, constraints) {
                double dialogWidth =
                    constraints.maxWidth * 0.9; // 90% da largura disponível
                if (dialogWidth > 500) {
                  dialogWidth = 500; // Limite máximo de largura
                }

                return ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: dialogWidth),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Novo Funcionário',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blue,
                                    ),
                                  ),
                                )),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Inputs(
                                    text: "Nome",
                                    controller: _nomeController,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Tipo de Acesso',
                                        style: TextStyle(
                                            color: AppColors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          CheckBox(
                                            tipo: 'gerente',
                                            controller: _tipoController,
                                          ),
                                          const Text(
                                            'Gerente',
                                            style: TextStyle(
                                                color: AppColors.blue),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox(
                                            tipo: 'padrao',
                                            controller: _tipoController,
                                          ),
                                          const Text(
                                            'Funcionário',
                                            style: TextStyle(
                                                color: AppColors.blue),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Setor*",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Dropdownbutton(
                                        controller: _setorController,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  InputTextField(
                                    type: 'email',
                                    labelText: 'Email',
                                    hintText: 'Email do funcionário',
                                    controller: _emailController,
                                  ),
                                  const SizedBox(height: 16),
                                  InputTextField(
                                    labelText: "Nome de usuário:",
                                    hintText: "Nome de usuário do funcionário",
                                    controller: _usuarioController,
                                  ),
                                  const SizedBox(height: 16),
                                  InputTextField(
                                    type: 'password',
                                    labelText: 'Senha',
                                    hintText: 'Senha para o funcionário',
                                    controller: _senhaController,
                                  ),
                                  const SizedBox(height: 16),
                                  InputTextField(
                                    type: 'confirmPassword',
                                    labelText: "Confirmar senha:",
                                    hintText:
                                        "Confirme a senha para o funcionário",
                                    controller: _confirmarSenhaController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            RegisterButton(
                                nomeController: _nomeController,
                                usuarioController: _usuarioController,
                                setorController: _setorController,
                                emailController: _emailController,
                                senhaController: _senhaController)
                          ],
                        ))));
              }));
        });
  }
}
