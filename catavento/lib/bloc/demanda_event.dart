part of 'demanda_bloc.dart';

sealed class DemandaEvent {
  const DemandaEvent();
}

class DemandaFilter extends DemandaEvent {
  final String column;
  final String value;

  const DemandaFilter(this.column, this.value);
}

class DemandaCreate extends DemandaEvent {
  final String nomeDemanda;
  final String codigo;
  final String descricao;
  final String status;
  final File? foto;

  const DemandaCreate({
    required this.nomeDemanda,
    required this.codigo,
    required this.descricao,
    this.status = "0",
    this.foto,
  });
}

class DemandaDelete extends DemandaEvent {
  final int id;
  final int order;

  const DemandaDelete(this.id, this.order);
}

class DemandaUpdate extends DemandaEvent {
  final int id;
  final int order;
  final String nomeDemanda;
  final String codigo;
  final String descricao;

  const DemandaUpdate(
    this.id,
    this.order,
    this.nomeDemanda,
    this.codigo,
    this.descricao,
  );
}

class DemandaLoading extends DemandaEvent {}
