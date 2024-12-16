part of 'usuario_bloc.dart';

sealed class UsuarioEvent {
  const UsuarioEvent();
}

class UsuarioCreate extends UsuarioEvent {
  final String nome;
  final String setor;
  final String email;
  final String tipo;

  const UsuarioCreate(
    this.nome,
    this.setor,
    this.email,
    this.tipo,
  );
}

class UsuarioDelete extends UsuarioEvent {
  final int id;
  final int order;

  const UsuarioDelete(
    this.id,
    this.order,
  );
}

class UsuarioUpdate extends UsuarioEvent {
  final int id;
  final String nome;
  final String setor;
  final String email;
  final String tipo;

  const UsuarioUpdate(
    this.nome,
    this.setor,
    this.email,
    this.tipo,
    this.id,
  );
}

class UsuarioLoading extends UsuarioEvent {}
