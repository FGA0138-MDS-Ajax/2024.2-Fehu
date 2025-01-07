part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEmailAddressChanged extends LoginEvent {
  final String value;
  LoginEmailAddressChanged(this.value);
}

class LoginPasswordChanged extends LoginEvent {
  final String value;
  LoginPasswordChanged(this.value);
}

class LoginButtonPressed extends LoginEvent {}
