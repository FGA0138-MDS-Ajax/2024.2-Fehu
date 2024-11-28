import 'package:catavento/constants.dart';
import 'package:catavento/services/table_import/csv_import_service.dart';
import 'package:catavento/services/table_import/table_picker.dart';
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
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final supabase = Supabase.instance.client;
                await supabase.auth.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed(loginRoute);
                }
              },
              child: const Text("Sair"),
            ),
            TextButton(
              onPressed: () async {
                final path = await tablePicker();
                print(path);
              },
              child: const Text("Procurar arquivo"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImportPage()),
                );
              },
              child: Text('Importar CSV'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importar CSV'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final filePath = 'CaminhoRelativoDoArquivo';
            importCSVtoSupabase(filePath);
          },
          child: Text('Importar CSV'),
        ),
      ),
    );
  }
}
