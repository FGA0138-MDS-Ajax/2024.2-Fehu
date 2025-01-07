import 'package:catavento/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSignIn extends StatefulWidget {
  final Widget title;
  final Icon icon;
  final bool isLoading;

  final Function() onPressed;

  const ButtonSignIn(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      required this.isLoading});

  @override
  State<ButtonSignIn> createState() => _ButtonSignInState();
}

class _ButtonSignInState extends State<ButtonSignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => ElevatedButton(
              onPressed: () {
                state.isSubmitting() || !state.isValid
                    ? null
                    : context.read<LoginBloc>().add(LoginButtonPressed());
                widget.onPressed();
              },
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
                                widget.title,
                                SizedBox(
                                  width: 5,
                                ),
                                widget.icon,
                              ],
                            ))),
            ));
  }
}
