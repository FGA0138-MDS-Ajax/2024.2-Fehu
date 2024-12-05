import 'dart:io';

import 'package:catavento/typedefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'demanda_event.dart';
part 'demanda_state.dart';

class DemandaBloc extends Bloc<DemandaEvent, DemandaState> {
  final supabase = Supabase.instance.client;
  DatabaseResponse currentData = [];

  DemandaEvent get initialState => DemandaLoading();

  DemandaBloc() : super(LoadingState([])) {
    on<DemandaFilter>(_onFilter);

    on<DemandaLoading>(_onLoading);

    on<DemandaCreate>(_onCreate);

    on<DemandaDelete>(_onDelete);
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
    if (newData.isEmpty) {
      emit(FilterState(currentData));
    } else {
      emit(FilterState(newData));
    }
  }

  void _onLoading(DemandaLoading event, Emitter<DemandaState> emit) async {
    final response = await supabase.from('demandas').select();
    currentData = response;
    emit(LoadingState(currentData));
  }

  void _onCreate(DemandaCreate event, Emitter<DemandaState> emit) async {
    String? fotoUrl;

    final demanda = {
      'nomeDemanda': event.nomeDemanda,
      'codigo': event.codigo,
      'descricao': event.descricao,
      'status': event.status,
    };

    if (event.foto != null) {
      try {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        await supabase.storage.from('imagens').upload(fileName, event.foto!);
        fotoUrl = supabase.storage.from('imagens').getPublicUrl(fileName);
      } catch (_) {
        throw Exception('Erro ao fazer upload da foto');
      }
    }

    if (fotoUrl != null) {
      demanda['imagemUrl'] = fotoUrl;
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
    emit(CreateState(currentData));
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
    emit(DeleteState(currentData));
  }
}