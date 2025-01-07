part of 'produto_bloc.dart';

sealed class ProdutoEvent {
  const ProdutoEvent();
}

class ProdutoFilter extends ProdutoEvent {
  final String column;
  final String value;

  const ProdutoFilter(this.column, this.value);
}

class ProdutoCreate extends ProdutoEvent {
  final String nomeProduto;
  final String descricaoPadrao;
  final File? imagemProduto;

  const ProdutoCreate(
    this.nomeProduto,
    this.descricaoPadrao,
    this.imagemProduto,
  );
}

class ProdutoDelete extends ProdutoEvent {
  final int id;

  const ProdutoDelete(
    this.id,
  );
}

class ProdutoUpdate extends ProdutoEvent {
  final int id;
  final String nomeProduto;
  final String descricaoProduto;
  final File? imagemProduto;

  const ProdutoUpdate(
    this.id,
    this.nomeProduto,
    this.descricaoProduto,
    this.imagemProduto,
  );
}

class ProdutoLoading extends ProdutoEvent {}
