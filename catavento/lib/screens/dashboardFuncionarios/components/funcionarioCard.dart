import 'package:catavento/bloc/usuario/usuario_bloc.dart';
import 'package:catavento/screens/dashboardFuncionarios/components/infoFuncionarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widgets/input.dart';
import 'package:catavento/shared/widgets/confirmDialog.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'DropDownButton.dart';
import 'checkBox.dart';

class FuncionarioCard extends StatefulWidget {
  final String nomeFuncionario;
  final String status;
  final String setor;
  final String email;

  const FuncionarioCard({
    super.key,
    required this.nomeFuncionario,
    required this.setor,
    required this.status,
    required this.email,
  });

  @override
  State<FuncionarioCard> createState() {
    return FuncionarioCardState();
  }
}

class FuncionarioCardState extends State<FuncionarioCard> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<UsuarioBloc>().getUser(widget.email)!;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          widget.nomeFuncionario,
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Setor: ${widget.setor}\nStatus: ${widget.status}',
          style: TextStyle(color: AppColors.blue),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.info),
              color: AppColors.blue,
              onPressed: () {
                //Lógica ao clicar
                _showInfoEmployeeDialog(user, context);
              },
            ),
            // botão de Editar.
            IconButton(
              icon: Icon(Icons.edit),
              color: AppColors.blue,
              onPressed: () {
                //  editar a demanda
                _showEditEmployeeDialog(context, user);
              },
            ),
            // apagar
            IconButton(
                icon: Icon(Icons.delete),
                color: AppColors.blue,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog(
                        title: 'Confirmar Exclusão',
                        contente:
                            'Tem certeza de que deseja apagar este funcionário?',
                        onConfirm: () {
                          context.read<UsuarioBloc>().add(UsuarioDelete(
                                user['id'],
                                user['email'],
                              ));
                          Navigator.of(context).pop();
                          //Lógica do botão
                        },
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  void _showEditEmployeeDialog(
      BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: LayoutBuilder(
            builder: (context, constraints) {
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
                                'Editar Funcionario',
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
                                hint: user['nome'],
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
                                        style: TextStyle(color: AppColors.blue),
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
                                        style: TextStyle(color: AppColors.blue),
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
                              Inputs(
                                text: "Email",
                                controller: _emailController,
                                hint: user['email'],
                              ),
                              const SizedBox(height: 16),
                              Inputs(
                                text: "Nome de Usuário",
                                controller: _usuarioController,
                                hint: user['usuario'],
                              ),
                              const SizedBox(height: 16),
                              Inputs(
                                text: "Senha",
                                controller: _senhaController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<UsuarioBloc>().add(UsuarioUpdate(
                                  _nomeController.text,
                                  _setorController.text,
                                  _tipoController.text,
                                  _emailController.text.isEmpty
                                      ? user['email']
                                      : _emailController.text.isEmpty,
                                  _usuarioController.text,
                                  user['id'],
                                ));
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          child: const Text(
                            "Concluir",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showInfoEmployeeDialog(
      Map<String, dynamic> user, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: LayoutBuilder(
            builder: (context, constraints) {
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
                                user['usuario'],
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
                              Infofuncionarios(
                                  nome: user['nome'],
                                  email: user['email'],
                                  status: "Indisponível",
                                  setor: user['setor'],
                                  demanda:
                                      "Indisponível") //Trocar para as informações do banco de dados
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
