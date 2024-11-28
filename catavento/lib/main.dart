import 'package:catavento/constants.dart';
import 'package:catavento/views/home_view.dart';
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
      homeRoute: (context) => const HomeView(),
    },
  ));
}

class LoadView extends StatelessWidget {
  const LoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Supabase.initialize(
          url: supabaseUrl,
          anonKey: supabaseKey,
          authOptions: const FlutterAuthClientOptions(
            authFlowType: AuthFlowType.implicit,
          )),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const HomeView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
