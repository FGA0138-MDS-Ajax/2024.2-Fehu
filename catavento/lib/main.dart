import 'package:catavento/constants.dart';
import 'package:catavento/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: "Gestão Catavento",
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const LoadView(),
    routes: {
      loginRoute: (context) => const LoginView(),
    },
  ));
}

class LoadView extends StatelessWidget {
  const LoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Supabase.initialize(
          url: "https://gfxmrqhwjqekfzrlurqr.supabase.com",
          anonKey: String.fromEnvironment("ANON_KEY")),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final supabase = Supabase.instance.client;
            final user = supabase.auth.currentUser;
            if (user != null) {
              return const Text("Hey");
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
