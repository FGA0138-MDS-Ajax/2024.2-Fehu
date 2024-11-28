import 'package:flutter/material.dart';
import 'screens/dashboard_admin.dart'; // Importando a tela DashboardAdmin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DashBoard',
      // A tela inicial será a DashBoardAdmin
      home: DashBoardAdmin(),
    );
  }
}
