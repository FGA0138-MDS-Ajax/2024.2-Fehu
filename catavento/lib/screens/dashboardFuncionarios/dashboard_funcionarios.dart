import 'package:flutter/material.dart';

import 'package:catavento/screens/dashboardAdmin/components/menu.dart';
import '../../services/table_import/table_import.dart';
import '../../services/table_import/table_picker.dart';

class DashBoardFuncionarios extends StatelessWidget {
  const DashBoardFuncionarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF015C98),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20), // Padding aqui
              child: Material(
                color: Colors.transparent, // Mantém o fundo transparente
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // Abre o Drawer
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 40.0,
                    color: Color(0xFF015C98),
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 20), // Ajuste o valor conforme necessário
            child: TextButton.icon(
              icon: const Icon(Icons.history, size: 18.0),
              label: const Text("Ver Histórico"),
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF015C98),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF015C98),
        onPressed: () async {
          final filePath = await tablePicker();
          if (filePath != null) {
            await importExcelToSupabase(filePath);
          }
        },
        child: Icon(Icons.upload_file, color: Colors.white),
      ),
    );
  }
}
