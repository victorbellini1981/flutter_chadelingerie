class Produtos {
  String idproduto;
  String referencia;
  String descricao;
  String tamanho;
  // ignore: non_constant_identifier_names
  double preco_tabela;
  String marca;
  String link;

  Produtos({
    this.idproduto,
    this.referencia,
    this.descricao,
    this.tamanho,
    // ignore: non_constant_identifier_names
    this.preco_tabela,
    this.marca,
    this.link,
  });

  Produtos.fromJson(Map<String, dynamic> json) {
    idproduto = json['idproduto'];
    referencia = json['referencia'];
    descricao = json['descricao'];
    tamanho = json['tamanho'];
    preco_tabela = json['preco_tabela'];
    marca = json['marca'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idproduto'] = this.idproduto;
    data['referencia'] = this.referencia;
    data['descricao'] = this.descricao;
    data['tamanho'] = this.tamanho;
    data['preco_tabela'] = this.preco_tabela;
    data['marca'] = this.marca;
    data['link'] = this.link;

    return data;
  }
}
