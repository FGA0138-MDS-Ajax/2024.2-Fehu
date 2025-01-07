import 'package:catavento/constants.dart';
import 'package:catavento/typedefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'trabalho_event.dart';
part 'trabalho_state.dart';

class TrabalhoBloc extends Bloc<TrabalhoEvent, TrabalhoState> {
  final _supabase = Supabase.instance.client;
  DatabaseResponse _currentData = [];
  DatabaseResponse _demandas = [];

  TrabalhoEvent get initialState =>
      TrabalhoLoading(email: _supabase.auth.currentUser!.email!);

  TrabalhoBloc() : super(TrabalhoLoadingState([], [], {})) {
    on<TrabalhoLoading>(_onLoading);

    on<TrabalhoInit>(_onInit);

    on<TrabalhoFinish>(_onFinish);
  }

  void _onLoading(TrabalhoLoading event, Emitter<TrabalhoState> emit) async {
    _currentData = await _supabase
        .from('trabalho')
        .select()
        .eq('usuario_email', event.email);

    for (var demanda in _currentData) {
      var response = await _supabase
          .from('demandas')
          .select()
          .eq('id', demanda['demanda_id']);
      if (response.isNotEmpty) {
        _demandas.add(response.first);
      }
    }

    emit(TrabalhoLoadingState(_currentData, _demandas, {}));
  }

  void _onInit(TrabalhoInit event, Emitter<TrabalhoState> emit) async {
    final response = await _supabase
        .from('demandas')
        .select()
        .eq('status_${event.setor}', 0)
        .order('data_adicao');

    if (response.isNotEmpty) {
      final demanda = response.first;
      final data = DateFormat(timeFormat).format(DateTime.now());
      final trabalho = {
        'demanda_id': demanda['id'],
        'usuario_email': event.email,
        'data_inicio': data,
      };

      try {
        await _supabase.from('trabalho').insert(trabalho);
        _currentData.add(trabalho);
        _demandas.add(demanda);
        emit(TrabalhoInitState(
          _currentData,
          _demandas,
          {},
        ));
      } catch (e) {
        print('Erro ao receber demanda: $e');
      }
    }
  }

  void _onFinish(TrabalhoFinish event, Emitter<TrabalhoState> emit) {}
}
