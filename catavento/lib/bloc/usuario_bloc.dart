// import 'dart:io';

// import 'package:catavento/bloc/demanda_bloc.dart';
// import 'package:catavento/constants.dart';
// import 'package:catavento/bloc/demanda_bloc.dart';
import 'package:catavento/typedefs.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart';
// import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final supabase = Supabase.instance.client;
  DatabaseResponse currentData = [];
  UsuarioEvent get initialState => UsuarioLoading();

  UsuarioBloc() : super(UsuarioLoadingState([], {})) {
    on<UsuarioLoading>(_onLoading);

    on<UsuarioCreate>(_onCreate);

    on<UsuarioDelete>(_onDelete);

    on<UsuarioUpdate>(_onUpdate);
  }

  void _onCreate(UsuarioCreate event, Emitter<UsuarioState> emit) async {
    final usuario = {
      'usuario_nome': event.nome,
      'email': event.email,
      'setor': event.setor,
      'tipo': event.tipo
    };

    try {
      final response = await supabase.from('usuarios').insert(usuario).select();
      if (response.isNotEmpty) {
        currentData.add(response[0]);
      } else {
        throw Exception("Erro ao adiciona usuario");
      }
    } catch (_) {
      throw Exception('Erro ao adicionar usuario');
    }

    final metaData = _countUsuarios();

    emit(UsuarioCreateState(currentData, metaData));
  }

  void _onDelete(UsuarioDelete event, Emitter<UsuarioState> emit) async {
    try {
      final response =
          await supabase.from('usuarios').delete().eq('id', event.id).select();
      if (response.isNotEmpty) {
        currentData.removeAt(event.order);
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }

    final metaData = _countUsuarios();

    emit(UsuarioDeleteState(currentData, metaData));
  }

  void _onUpdate(UsuarioUpdate event, Emitter<UsuarioState> emit) async {
    try {
      final nome = event.nome;
      final setor = event.setor;
      final email = event.email;
      final tipo = event.tipo;
      final id = event.id;

      await supabase.from('usuarios').update({
        'nome': nome,
        'setor': setor,
        'email': email,
        'tipo': tipo,
      }).eq('id', event.id);

      // verificar se pode usar o id
      currentData[id]['nome'] = nome;
      currentData[id]['setor'] = setor;
      currentData[id]['email'] = email;
      currentData[id]['tipo'] = tipo;

      final metaData = _countUsuarios();

      emit(UsuarioUpdateState(currentData, metaData));
    } catch (e) {
      print("Erro ao atualizar usuario: $e");
    }
  }

  void _onLoading(UsuarioLoading event, Emitter<UsuarioState> emit) async {
    final response = await supabase.from('usuarios').select();
    currentData = response;

    final metaData = _countUsuarios();

    emit(UsuarioLoadingState(currentData, metaData));
  }

  Map<String, int> _countUsuarios() {
    int numUsuarios = 0;

    for (var usuario in currentData) {
      if (usuario["tipo"] == "funcionario") {
        numUsuarios++;
      }
    }
    final metaData = {"total": numUsuarios};
    return metaData;
  }
}
