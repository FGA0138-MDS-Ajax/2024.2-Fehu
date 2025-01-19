import 'package:catavento/bloc/auth/auth_bloc.dart';
import 'package:catavento/main.dart';
import 'package:catavento/screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSignIn extends StatefulWidget {
  final Icon icon;
  final bool isLoading;

  final VoidCallback onPressed;

  const ButtonSignIn(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.isLoading});

  @override
  State<ButtonSignIn> createState() => _ButtonSignInState();
}

class _ButtonSignInState extends State<ButtonSignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => InkWell(
              onTap: () {}
              ,
              child: Container(
                  height: 45,
                  width: 114,
                  decoration: BoxDecoration(
                      color: Color(0xFF75CDF3),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                      child: widget.isLoading
                          ? Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                color: Color(0xFFED5EA3),
                                backgroundColor: Colors.white,
                              ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Entrar",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                widget.icon,
                              ],
                            ))),
            ));
  }
}
