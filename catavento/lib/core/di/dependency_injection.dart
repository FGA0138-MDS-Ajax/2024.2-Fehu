import 'package:catavento/core/di/dependency_injection.config.dart';
import 'package:catavento/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:catavento/data/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';
// import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:catavento/bloc/auth/auth_bloc.dart';
// import 'package:catavento/bloc/login/login_bloc.dart';
// import 'package:catavento/bloc/registration/registration_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:gotrue/src/gotrue_client.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

void setupDependencies() {
  // final supabase = Supabase.instance.client;

  getIt.registerLazySingleton(() => Supabase.instance.client);

  getIt.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(getIt()));

  getIt.registerFactory(() => AuthBloc(getIt<IAuthenticationRepository>()));
  // getIt.registerSingleton<LoginBloc>(
  //     LoginBloc(getIt<AuthenticationRepository>()));
  // getIt.registerSingleton<RegistrationBloc>(
  //     RegistrationBloc(getIt<AuthenticationRepository>()));
}
