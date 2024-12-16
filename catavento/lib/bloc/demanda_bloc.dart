import 'dart:io';

import 'package:catavento/constants.dart';
import 'package:catavento/typedefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'demanda_event.dart';
part 'demanda_state.dart';

class DemandaBloc extends Bloc<DemandaEvent, DemandaState> {
  final supabase = Supabase.instance.client;
  DatabaseResponse currentData = [];
  File? fotoSelecionada;

  DemandaEvent get initialState => DemandaLoading();

  DemandaBloc() : super(DemandaLoadingState([], {})) {
    on<DemandaFilter>(_onFilter);

    on<DemandaLoading>(_onLoading);

    on<DemandaCreate>(_onCreate);

    on<DemandaDelete>(_onDelete);

    on<DemandaUpdate>(_onUpdate);
  }

  void _onFilter(DemandaFilter event, Emitter<DemandaState> emit) {
    final column = event.column;
    var value = event.value;
    DatabaseResponse newData = [];

    if (value != "") {
      value = value.toLowerCase();
      for (var data in currentData) {
        if (data[column] != null) {
          var string = data[column] as String;
          string = string.toLowerCase();
          if (string.contains(value)) {
            newData.add(data);
          }
        }
      }
    }

    final metaData = _countDemandas();

    if (newData.isEmpty) {
      emit(DemandaFilterState(currentData, metaData));
    } else {
      emit(DemandaFilterState(newData, metaData));
    }
  }

  void _onLoading(DemandaLoading event, Emitter<DemandaState> emit) async {
    final response = await supabase.from('demandas').select();
    currentData = response;

    final metaData = _countDemandas();

    emit(DemandaLoadingState(currentData, metaData));
  }

  void _onCreate(DemandaCreate event, Emitter<DemandaState> emit) async {
    String? fotoUrl;
    if (event.foto != null) {
      try {
        final filename = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        await supabase.storage.from('imagens').upload(filename, event.foto!);
        fotoUrl = supabase.storage.from('imagens').getPublicUrl(filename);
      } catch (error) {
        throw Exception('Erro ao fazer upload da foto: $error');
      }
    }

    final dataAdicao = DateFormat(timeFormat).format(DateTime.now());

    print('Teste');
    print(event.descricao);

    final demanda = {
      'nome_demanda': event.nomeDemanda,
      'descricao': event.descricao == '' ? 'Bolo normal' : event.descricao,
      'status': 'Pendente',
      'status_cobertura': 0,
      'status_aplique': 0,
      'data_adicao': dataAdicao,
      'prioridade': 'media',
    };

    if (fotoUrl != null) {
      demanda['image_url'] = fotoUrl;
    }

    try {
      final response = await supabase.from('demandas').insert(demanda).select();
      if (response.isNotEmpty) {
        currentData.add(response[0]);
      } else {
        throw Exception("Erro ao adiciona demanda");
      }
    } catch (_) {
      throw Exception('Erro ao adicionar demanda');
    }

    final metaData = _countDemandas();

    emit(DemandaCreateState(currentData, metaData));
  }

  void _onDelete(DemandaDelete event, Emitter<DemandaState> emit) async {
    try {
      final response =
          await supabase.from('demandas').delete().eq('id', event.id).select();
      if (response.isNotEmpty) {
        currentData.removeAt(event.order);
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }

    final metaData = _countDemandas();

    emit(DemandaDeleteState(currentData, metaData));
  }

  void _onUpdate(DemandaUpdate event, Emitter<DemandaState> emit) async {
    try {
      final nomeDemanda = event.nomeDemanda;
      final descricao = event.descricao;
      final order = event.order;

      await supabase.from('demandas').update({
        'nome_demanda': nomeDemanda,
        'descricao': descricao,
      }).eq('id', event.id);

      currentData[order]['nome_demanda'] = nomeDemanda;
      currentData[order]['descricao'] = descricao;

      final metaData = _countDemandas();

      emit(DemandaUpdateState(currentData, metaData));
    } catch (e) {
      print("Erro ao atualizar demanda: $e");
    }
  }

  Map<String, int> _countDemandas() {
    int completo = 0;
    int espera = 0;
    int fabricacao = 0;

    for (var data in currentData) {
      switch (data['status']) {
        case '0' || 'Pendente':
          espera++;
        case '1' || 'Em fabricação':
          fabricacao++;
        case '2' || 'Finalizado':
          completo++;
      }
    }

    int total = espera + fabricacao + completo;
    int restantes = espera + fabricacao;

    final metaData = {
      'completo': completo,
      'espera': espera,
      'fabricacao': fabricacao,
      'total': total,
      'restantes': restantes,
    };

    return metaData;
  }
}
