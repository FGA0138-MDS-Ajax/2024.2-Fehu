import 'package:catavento/bloc/demanda_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DemandaController {
  final _client = Supabase.instance.client;
  final DemandaBloc _bloc;
  late final RealtimeChannel _channel;

  DemandaController(this._bloc);

  void initialize() async {
    await _client.removeAllChannels();
    _channel = _client
        .channel('public:demandas')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'demandas',
          callback: (payload) {
            _bloc.add(DemandaLoading());
          },
        )
        .subscribe();
  }

  Future<void> finalize() async {
    await _client.removeChannel(_channel);
  }
}
