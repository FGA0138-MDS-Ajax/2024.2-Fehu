import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catavento/domain/repositories/authentication/i_authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;
  // StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOut);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    // _startUserSubscription();
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
          email: event.email, password: event.password);
      final user = await _authenticationRepository.getCurrentUser();

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Falha ao criar conta. Verifique suas credenciais."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authenticationRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final user = await _authenticationRepository.getCurrentUser();

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Falha ao fazer login."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await _authenticationRepository.signOut();
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthEvent(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authenticationRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
