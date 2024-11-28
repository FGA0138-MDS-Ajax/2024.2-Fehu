import 'package:catavento/constants.dart';
import 'package:catavento/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    final authSubsctiption = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(homeRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await AuthService.azureSignIn();
          },
          child: const Text("Entre pela microsoft"),
        ),
      ),
    );
  }
}
