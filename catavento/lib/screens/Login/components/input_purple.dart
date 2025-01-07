import 'package:catavento/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurpleTextField extends StatelessWidget {
  final String type;
  final String label;
  final Icon icon;

  const PurpleTextField(
      {super.key, required this.type, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 324,
        height: 68,
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) {
            if (type == 'email') {
              return current.email != previous.email;
            } else {
              return current.password != previous.password;
            }
          },
          builder: (context, state) => TextField(
            onChanged: (value) {
              if (type == 'email') {
                context.read<LoginBloc>().add(LoginEmailAddressChanged(value));
              } else {
                context.read<LoginBloc>().add(LoginPasswordChanged(value));
              }
            },
            keyboardType: type == 'email' ? TextInputType.emailAddress : TextInputType.visiblePassword,
            obscureText: type == 'password' ? true : false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(4.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFFACACAC))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0x80FC298F))),
                prefixIcon: icon,
                filled: true,
                fillColor: Color(0xFFDEE1FF),
                labelText: label,
                labelStyle: TextStyle(
                    color: Color(0xCCACACAC),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100),
                errorText: type == 'email'
                    ? state.email.hasError
                        ? state.email.errorMessage
                        : null
                    : state.password.hasError
                        ? state.password.errorMessage
                        : null),
          ),
        ));
  }
}
