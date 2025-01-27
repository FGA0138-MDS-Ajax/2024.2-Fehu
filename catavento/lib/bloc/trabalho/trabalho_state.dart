part of 'trabalho_bloc.dart';

sealed class TrabalhoState {
  final DatabaseResponse trabalho;
  final DatabaseResponse demandas;
  final Map<String, int> metaData;

  const TrabalhoState(
    this.trabalho,
    this.demandas,
    this.metaData,
  );
}

class TrabalhoGetState extends TrabalhoState {
  TrabalhoGetState(
    super.trabalho,
    super.demandas,
    super.metaData,
  );
}

class TrabalhoInitState extends TrabalhoState {
  TrabalhoInitState(
    super.trabalho,
    super.demandas,
    super.metaData,
  );
}

class TrabalhoFinishState extends TrabalhoState {
  TrabalhoFinishState(
    super.trabalho,
    super.demandas,
    super.metaData,
  );
}

class TrabalhoLoadingState extends TrabalhoState {
  TrabalhoLoadingState(
    super.trabalho,
    super.demandas,
    super.metaData,
  );
}

class TrabalhoEmptyState extends TrabalhoState {
  TrabalhoEmptyState(
    super.trabalho,
    super.demandas,
    super.metaData,
  );
}

class TrabalhoErrorState extends TrabalhoState {
  final String message;

  TrabalhoErrorState(
    super.trabalho,
    super.demandas,
    super.metaData,
    this.message,
  );
}
