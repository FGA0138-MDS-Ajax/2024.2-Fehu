import 'package:catavento/constants.dart';
import 'package:catavento/services/csv_import_service.dart';
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
            // Sign-out button
            TextButton(
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
            // Button to navigate to ImportPage
            ElevatedButton(
              onPressed: () {
                // Navigate to the ImportPage
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
            final filePath = 'CaminhoRelativoDoArquivo'; //aqui botar o caminho relativo do arquivo.
                                                      //futuramente trocar por uma busca pelo arquivo
            importCSVtoSupabase(filePath);
          },
          child: Text('Importar CSV'),
        ),
      ),
    );
  }
}
