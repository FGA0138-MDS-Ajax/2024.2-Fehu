part of 'usuario_bloc.dart';

sealed class UsuarioEvent {
  const UsuarioEvent();
}

class UsuarioCreate extends UsuarioEvent {
  final String nome;
  final String usuario;
  final String setor;
  final String email;
  final String tipo;
  final String senha;

  const UsuarioCreate(
    this.nome,
    this.usuario,
    this.setor,
    this.email,
    this.tipo,
    this.senha,
  );
}

class UsuarioDelete extends UsuarioEvent {
  final int order;
  final String email;

  const UsuarioDelete(
    this.order,
    this.email,
  );
}

class UsuarioUpdate extends UsuarioEvent {
  final int id;
  final String nome;
  final String setor;
  final String tipo;
  final String email;
  final String usuario;

  const UsuarioUpdate(
    this.nome,
    this.setor,
    this.tipo,
    this.email,
    this.usuario,
    this.id,
  );
}

class UsuarioLoading extends UsuarioEvent {}
