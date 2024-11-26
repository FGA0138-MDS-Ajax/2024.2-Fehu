import 'package:catavento/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            await supabase.auth.signOut();
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (_) => true,
              );
            }
          },
          child: const Text("Sair"),
        ),
      ),
    );
  }
}
