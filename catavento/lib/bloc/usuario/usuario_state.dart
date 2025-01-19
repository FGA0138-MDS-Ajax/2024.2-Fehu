part of 'usuario_bloc.dart';

sealed class UsuarioState {
  final DatabaseResponse databaseResponse;
  final Map<String, int> metaData;

  const UsuarioState(this.databaseResponse, this.metaData);
}

class UsuarioCreateState extends UsuarioState {
  UsuarioCreateState(super.databaseResponse, super.metaData);
}

class UsuarioDeleteState extends UsuarioState {
  UsuarioDeleteState(super.databaseResponse, super.metaData);
}

class UsuarioUpdateState extends UsuarioState {
  UsuarioUpdateState(super.databaseResponse, super.metaData);
}

class UsuarioLoadingState extends UsuarioState {
  UsuarioLoadingState(super.databaseResponse, super.metaData);
}

class UsuarioErrorState extends UsuarioState {
  final String message;

  UsuarioErrorState(super.databaseResponse, super.metaData, this.message);
}
