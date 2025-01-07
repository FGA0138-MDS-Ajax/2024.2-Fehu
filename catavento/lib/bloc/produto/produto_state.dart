part of 'produto_bloc.dart';

sealed class ProdutoState {
  final DatabaseResponse databaseResponse;
  final Map<String, int> metaData;

  const ProdutoState(this.databaseResponse, this.metaData);
}

class ProdutoCreateState extends ProdutoState {
  ProdutoCreateState(super.databaseResponse, super.metaData);
}

class ProdutoDeleteState extends ProdutoState {
  ProdutoDeleteState(super.databaseResponse, super.metaData);
}

class ProdutoUpdateState extends ProdutoState {
  ProdutoUpdateState(super.databaseResponse, super.metaData);
}

class ProdutoLoadingState extends ProdutoState {
  ProdutoLoadingState(super.databaseResponse, super.metaData);
}

class ProdutoFilterState extends ProdutoState {
  ProdutoFilterState(super.databaseResponse, super.metaData);
}
