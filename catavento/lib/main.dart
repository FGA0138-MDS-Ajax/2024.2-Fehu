import 'package:catavento/bloc/auth/auth_bloc.dart' as auth_bloc;
import 'package:catavento/bloc/demanda/demanda_bloc.dart';
import 'package:catavento/bloc/login/login_bloc.dart';
import 'package:catavento/bloc/registration/registration_bloc.dart';
import 'package:catavento/bloc/usuario/usuario_bloc.dart';
import 'package:catavento/constants.dart';
import 'package:catavento/core/di/dependency_injection.dart';
import 'screens/DashboardAdmin/dashboard_admin.dart';
import 'package:catavento/screens/Login/login.dart';
import 'package:catavento/screens/dashboardFuncionarios/employee-management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  setupDependencies();
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DemandaBloc()..add(DemandaLoading())),
        BlocProvider(create: (context) => UsuarioBloc()..add(UsuarioLoading())),
        BlocProvider(
            create: (_) => getIt<auth_bloc.AuthBloc>()
              ..add(auth_bloc.AuthInitialCheckRequested())),
        BlocProvider(
            create: (_) => getIt<LoginBloc>()..add(LoginButtonPressed())),
        BlocProvider(
            create: (_) => getIt<RegistrationBloc>()
              ..add(RegistrationRegisterButtonPressed()))
      ],
      child: MaterialApp(
        title: "Gestão Catavento",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoadView(),
        routes: {
          loginRoute: (context) => const LoginForm(),
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
    return FutureBuilder(
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
            return BlocConsumer<auth_bloc.AuthBloc, auth_bloc.AuthState>(
              listener: (context, state) {
                if (state is auth_bloc.AuthUserUnauthenticated) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginForm()));
                }
                if (state is auth_bloc.AuthUserAuthenticated) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DashBoardAdmin()));
                }
              },
              builder: (context, state) => const CircularProgressIndicator(),
            );

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
