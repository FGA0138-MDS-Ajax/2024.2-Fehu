import 'package:catavento/core/di/dependency_injection.config.dart';
import 'package:catavento/bloc/auth/auth_bloc.dart';
import 'package:catavento/data/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:gotrue/src/gotrue_client.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

void setupDependencies() {
  getIt.registerSingleton<AuthenticationRepository>(
      AuthenticationRepository(GoTrueClient()));
  getIt
      .registerSingleton<AuthBloc>(AuthBloc(getIt<AuthenticationRepository>()));
}
