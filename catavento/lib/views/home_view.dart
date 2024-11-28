import 'package:catavento/constants.dart';
import 'package:catavento/services/table_import/csv_import_service.dart';
import 'package:catavento/services/table_import/table_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? caminhoArquivoSelecionado;

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
            // Logout Button
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
                if (path != null) {
                  print("Caminho do arquivo selecionado: $path");
                  setState(() {
                    caminhoArquivoSelecionado = path;
                  });

                  
                  print("Importando arquivo...");
                  await importExcelToSupabase(path);
                  print("Importação concluída!");
                } else {
                  print("Nenhum arquivo selecionado");
                }
              },
              child: const Text("Procurar e Importar Arquivo"),
            ),
            
            
            if (caminhoArquivoSelecionado != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Arquivo Selecionado: $caminhoArquivoSelecionado",
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


