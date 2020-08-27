class Produtos {
  String idproduto;
  String referencia;
  String descricao;
  String cor;
  String tamanhos;
  // ignore: non_constant_identifier_names
  double preco_tabela;
  String marca;
  String link;

  Produtos({
    this.idproduto,
    this.referencia,
    this.descricao,
    this.cor,
    this.tamanhos,
    // ignore: non_constant_identifier_names
    this.preco_tabela,
    this.marca,
    this.link,
  });

  Produtos.fromJson(Map<String, dynamic> json) {
    idproduto = json['idproduto'];
    referencia = json['referencia'];
    descricao = json['descricao'];
    cor = json['cor'];
    tamanhos = json['tamanhos'];
    preco_tabela = json['preco_tabela'];
    marca = json['marca'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idproduto'] = this.idproduto;
    data['referencia'] = this.referencia;
    data['descricao'] = this.descricao;
    data['cor'] = this.cor;
    data['tamanhos'] = this.tamanhos;
    data['preco_tabela'] = this.preco_tabela;
    data['marca'] = this.marca;
    data['link'] = this.link;

    return data;
  }
}
