import 'package:catavento/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import '../services/csv_import_service.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            final supabase = Supabase.instance.client;
            await supabase.auth.signInWithOAuth(
              OAuthProvider.azure,
              authScreenLaunchMode: kIsWeb
                  ? LaunchMode.platformDefault
                  : LaunchMode.externalApplication,
            );
            final user = supabase.auth.currentUser;
            if (user != null) {
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  homeRoute,
                  (_) => true,
                );
              }
            }
          },
          child: const Text("Entre pela microsoft"),
        ),
      ),
    );
  }
}
