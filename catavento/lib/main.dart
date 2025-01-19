import 'package:catavento/bloc/auth/auth_bloc.dart' as auth_bloc;
import 'package:catavento/bloc/demanda/demanda_bloc.dart';
// import 'package:catavento/bloc/login/login_bloc.dart';
// import 'package:catavento/bloc/registration/registration_bloc.dart';
import 'package:catavento/bloc/usuario/usuario_bloc.dart';
import 'package:catavento/constants.dart';
import 'package:catavento/screens/DadosFuncionario/dadosFuncionario.dart';
import 'package:catavento/screens/Desempenho/dashboard_desempenhoAdmin.dart';
import 'package:catavento/screens/Produtos/dashboard_produtos.dart';
import 'package:catavento/core/di/dependency_injection.dart';
import 'package:catavento/screens/dashboardFuncionarios/employee-management.dart';
import 'screens/DashboardAdmin/dashboard_admin.dart';
import 'package:catavento/screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/Funcionario/dashboardfuncionario.dart';

void main() async {
  setupDependencies();
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DemandaBloc()..add(DemandaLoading())),
        BlocProvider(create: (context) => UsuarioBloc()..add(UsuarioLoading())),
        BlocProvider(
            create: (context) =>
                getIt<auth_bloc.AuthBloc>()..add(auth_bloc.CheckAuthEvent())),
        // BlocProvider(
        //     create: (_) => getIt<LoginBloc>()..add(LoginButtonPressed())),
        // BlocProvider(
        //     create: (_) => getIt<RegistrationBloc>()
        //       ..add(RegistrationRegisterButtonPressed()))
      ],
      child: MaterialApp(
        title: "Gestão Catavento",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Fredoka',
        ),
        home: const LoadView(),
        routes: {
          loginRoute: (context) => const LoginForm(),
          homeRoute: (context) => const DashBoardAdmin(),
          crudFuncionariosRoute: (context) => EmployeeManagement(),
          produtosRoute: (context) => DashboardProdutos(),
          atividadesFuncionarioRoute: (context) => DashBoardFuncionario(),
          dadosFuncionario: (context) => Dadosfuncionario(),
          desempenhoAdminRoute: (context) => DashboardDesempenhoAdmin(),
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
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocConsumer<auth_bloc.AuthBloc, auth_bloc.AuthState>(
            listener: (context, state) {
              if (state is auth_bloc.AuthError) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              }
              if (state is auth_bloc.AuthAuthenticated) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeManagement()));
              }
            },
            builder: (context, state) {
              if (state is auth_bloc.AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const LoginForm();
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
