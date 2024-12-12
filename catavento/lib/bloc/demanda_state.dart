part of "demanda_bloc.dart";

sealed class DemandaState {
  final DatabaseResponse databaseResponse;
  final Map<String, int> metaData;

  const DemandaState(this.databaseResponse, this.metaData);
}

class DemandaCreateState extends DemandaState {
  DemandaCreateState(super.databaseResponse, super.metaData);
}

class DemandaDeleteState extends DemandaState {
  DemandaDeleteState(super.databaseResponse, super.metaData);
}

class DemandaUpdateState extends DemandaState {
  DemandaUpdateState(super.databaseResponse, super.metaData);
}

class DemandaLoadingState extends DemandaState {
  DemandaLoadingState(super.databaseResponse, super.metaData);
}

class DemandaFilterState extends DemandaState {
  DemandaFilterState(super.databaseResponse, super.metaData);
}
