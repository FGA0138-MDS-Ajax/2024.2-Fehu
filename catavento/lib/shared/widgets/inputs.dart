import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catavento/bloc/registration/registration_bloc.dart';

class InputTextField extends StatelessWidget {
  final String type;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const InputTextField({
    super.key,
    this.type = '',
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) {
          switch (labelText) {
            case 'email':
              return current.email != previous.email;
            case 'password':
              return current.password != previous.password;
            case 'confirmPassword':
              return current.confirmPassword != previous.confirmPassword;
            default:
              return false;
          }
        },
        builder: (context, state) => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    onChanged: (value) {
                      switch (labelText) {
                        case 'email':
                          context
                              .read<RegistrationBloc>()
                              .add(RegistrationEmailAddressChanged(value));
                          break;
                        case 'password':
                          context
                              .read<RegistrationBloc>()
                              .add(RegistrationPasswordChanged(value));
                          break;
                        case 'confirmPassword':
                          context
                              .read<RegistrationBloc>()
                              .add(RegistrationConfirmPasswordChanged(value));
                          break;
                      }
                    },
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: isPassword,
                    inputFormatters: inputFormatters,
                    maxLines: maxLines, // Suporte para múltiplas linhas
                    decoration: InputDecoration(
                      labelText: labelText,
                      hintText: hintText,
                      errorText: labelText == 'email'
                          ? (state.email.hasError
                              ? state.email.errorMessage
                              : null)
                          : labelText == 'password'
                              ? (state.password.hasError
                                  ? state.password.errorMessage
                                  : null)
                              : (state.confirmPassword.hasError
                                  ? state.confirmPassword.errorMessage
                                  : null),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

Widget inputDate() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 95,
        height: 25,
        //input da data
        child: TextField(
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          decoration: InputDecoration(
              hintText: 'dd/mm/yy',
              hintStyle:
                  TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 2))),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.calendar_month,
        color: Colors.black26,
      )
    ],
  );
}
