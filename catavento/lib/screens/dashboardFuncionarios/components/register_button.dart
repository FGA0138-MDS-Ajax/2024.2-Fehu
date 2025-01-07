import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:catavento/bloc/registration/registration_bloc.dart';
import 'package:catavento/bloc/usuario/usuario_bloc.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController usuarioController;
  final TextEditingController setorController;
  final TextEditingController emailController;
  final TextEditingController senhaController;

  const RegisterButton({
    super.key,
    required this.nomeController,
    required this.usuarioController,
    required this.setorController,
    required this.emailController,
    required this.senhaController,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) => ElevatedButton(
              onPressed: () {
                context.read<UsuarioBloc>().add(UsuarioCreate(
                      nomeController.text,
                      usuarioController.text,
                      setorController.text,
                      emailController.text,
                      'padrao',
                      senhaController.text,
                    ));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22))),
              child: Text(
                "Concluir",
                style: TextStyle(color: Colors.white),
              )));
}
