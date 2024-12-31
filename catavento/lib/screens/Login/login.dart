import 'dart:developer';
import 'package:catavento/bloc/login/login_bloc.dart';
import 'package:catavento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/input_purple.dart';
import 'components/button_sign_in.dart';
import 'package:catavento/shared/widgets/showDialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current.isSubmissionSuccessOrFailure(),
      listener: (context, state) {
        if (state.formSubmissionStatus == FormSubmissionStatus.success) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoadView()));
        }
        if (state.formSubmissionStatus == FormSubmissionStatus.failure) {
          Showdialog(
              title:
                  'Falha de login. Por favor, verifique suas credenciais de acesso.');
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background gradient
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Container (ficará abaixo da imagem do bolo)

            Center(
              child: Container(
                width: 400.0,
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Outros widgets aqui
                    SizedBox(
                      height: 60,
                    ),
                    Form(
                        child: Column(
                      children: [
                        PurpleTextField(
                          type: 'email',
                          label: "Digite o seu e-mail de acesso",
                          icon: Icon(
                            Icons.person_outline,
                            color: Color(0xCCACACAC),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PurpleTextField(
                          type: 'password',
                          label: "Digite a sua senha",
                          icon: Icon(
                            Icons.lock_outline,
                            color: Color(0xCCACACAC),
                          ),
                        ),
                      ],
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 50, 20, 0),
                          child: ButtonSignIn(
                            title: Text(
                              "Entrar",
                              style: TextStyle(color: Colors.white),
                            ),
                            isLoading: isLoading,
                            icon: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                isLoading = !isLoading;
                              });
                            },
                          ),
                        )
                      ],
                    )
                    //SizedBox(height: 35),
                  ],
                ),
              ),
            ),

            Center(
              child: Transform.translate(
                offset: Offset(0, -230),
                // Mover a imagem 50 pixels para cima (ajuste conforme necessário)
                child: Image.asset(
                  "assets/images/cake.png",
                  width: 128,
                  height: 128,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
