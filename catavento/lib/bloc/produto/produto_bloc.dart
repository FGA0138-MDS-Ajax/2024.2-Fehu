import 'dart:io';

import 'package:catavento/bloc/demanda/demanda_bloc.dart';
import 'package:catavento/constants.dart';
import 'package:catavento/typedefs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'produto_event.dart';
part 'produto_state.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  final _supabase = Supabase.instance.client;
  DatabaseResponse _currentData = [];
  ProdutoEvent get initialState => ProdutoLoading();
  bool _newEvent = false;

  ProdutoBloc() : super(ProdutoLoadingState([], {})) {
    on<ProdutoFilter>(_onFilter);

    on<ProdutoLoading>(_onLoading);

    on<ProdutoCreate>(_onCreate);

    on<ProdutoDelete>(_onDelete);

    on<ProdutoUpdate>(_onUpdate);
  }

  @override
  void onEvent(ProdutoEvent event) {
    super.onEvent(event);
    _newEvent = true;
  }

  bool isLocalEvent() {
    if (_newEvent) {
      _newEvent = false;
      return _newEvent;
    } else {
      return true;
    }
  }

  void _onFilter(ProdutoFilter event, Emitter<ProdutoState> emit) {
    final column = event.column;
    var value = event.value;
    DatabaseResponse newData = [];

    if (value != "") {
      value = value.toLowerCase();

      for (var data in _currentData) {
        if (data[column] != null) {
          var string = data[column] as String;
          string = string.toLowerCase();

          if (string.contains(value)) {
            newData.add(data);
          }
        }
      }
    }

    final metaData = _countProdutos();

    if (newData.isEmpty) {
      emit(ProdutoFilterState(_currentData, metaData));
    } else {
      emit(ProdutoFilterState(newData, metaData));
    }
  }

  void _onLoading(ProdutoLoading event, Emitter<ProdutoState> emit) async {
    final response = await _supabase.from('produtos').select();
    _currentData = response;
    final metaData = _countProdutos();
    emit(ProdutoLoadingState(_currentData, metaData));
  }

  void _onCreate(ProdutoCreate event, Emitter<ProdutoState> emit) async {
    final produto = {
      'nome_produto': event.nomeProduto,
      'descricao_padrao': event.descricaoPadrao,
    };

    if (produto['nomeProduto'] != null && produto['nomeProduto']!.isEmpty) {
      try {
        final response =
            await _supabase.from('produtos').insert(produto).select();

        if (response.isNotEmpty) {
          _currentData.add(response[0]);
        } else {
          throw Exception("Erro ao adicionar produto");
        }
      } catch (_) {
        throw Exception("Erro ao adicionar produto");
      }
    }
    final metaData = _countProdutos();

    emit(ProdutoCreateState(_currentData, metaData));
  }

  void _onDelete(ProdutoDelete event, Emitter<ProdutoState> emit) async {
    try {
      final response =
          await _supabase.from('produtos').delete().eq('id', event.id).select();

      if (response.isNotEmpty) {
        _currentData.removeWhere((produto) => produto['id'] == event.id);
        final metaData = _countProdutos();
        emit(ProdutoDeleteState(_currentData, metaData));
      } else {
        throw Exception("Produto não encontrado");
      }
    } catch (_) {
      throw Exception("Erro ao deletar produto");
    }
  }

  void _onUpdate(ProdutoUpdate event, Emitter<ProdutoState> emit) async {
    final produtoAtualizado = {
      'nome_produto': event.nomeProduto,
      'descricao_padrao': event.descricaoProduto,
    };

    if (event.imagemProduto != null) {
      final filePath = await _uploadImage(event.imagemProduto!);
      produtoAtualizado['imagem_produto'] = filePath;
    }

    try {
      final response = await _supabase
          .from('produtos')
          .update(produtoAtualizado)
          .eq('id', event.id)
          .select();

      if (response.isNotEmpty) {
        _currentData = _currentData.map((produto) {
          if (produto['id'] == event.id) {
            return response[0];
          }
          return produto;
        }).toList();

        final metaData = _countProdutos();
        emit(ProdutoUpdateState(_currentData, metaData));
      } else {
        throw Exception("Erro ao atualizar produto");
      }
    } catch (_) {
      throw Exception("Erro ao atualizar produto");
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      final imageName =
          '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
      final response =
          await _supabase.storage.from('imagens').upload(imageName, image);

      if (response.isNotEmpty) {
        final publicUrl =
            _supabase.storage.from('imagens').getPublicUrl(imageName);
        return publicUrl ?? '';
      } else {
        throw Exception('Erro ao fazer upload da imagem: $response');
      }
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }

  Map<String, int> _countProdutos() {
    int numProdutos = _currentData.length;
    final metaData = {"total": numProdutos};
    return metaData;
  }
}
