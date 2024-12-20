import 'package:catavento/bloc/demanda_bloc.dart';
import 'package:catavento/constants.dart';
import 'screens/DashboardAdmin/dashboard_admin.dart';
import 'package:catavento/screens/Login/login.dart';
import 'package:catavento/screens/dashboardFuncionarios/employee-management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) =>
          DemandaBloc()..add(DemandaLoading()), // Providing the bloc here
      child: MaterialApp(
        title: "Gestão Catavento",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoadView(),
        routes: {
          loginRoute: (context) => const Login(),
          homeRoute: (context) => const DashBoardAdmin(),
          crudFuncionariosRoute: (context) => EmployeeManagement(),
        },
      ),
    ),
  );
}

class LoadView extends StatelessWidget {
  const LoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DemandaBloc()..add(DemandaLoading()), // Providing the bloc
      child: FutureBuilder(
        future: Supabase.initialize(
          url: supabaseUrl,
          anonKey: supabaseKey,
          authOptions: const FlutterAuthClientOptions(
            authFlowType: AuthFlowType.implicit,
          ),
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const DashBoardAdmin();
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
