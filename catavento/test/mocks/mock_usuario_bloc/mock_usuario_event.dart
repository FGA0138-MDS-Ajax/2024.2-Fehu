part of 'mock_usuario_bloc.dart';

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

class UsuarioFilter extends UsuarioEvent {
  final String campo;
  final String pesquisa;

  UsuarioFilter(this.campo, this.pesquisa);
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
  final String senha;

  const UsuarioUpdate(
    this.nome,
    this.setor,
    this.tipo,
    this.email,
    this.usuario,
    this.id,
    this.senha,
  );
}

class UsuarioLoading extends UsuarioEvent {}

class UsuerioError extends UsuarioEvent {}
