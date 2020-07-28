class Usuario {
  int idusuario;
  String nome;
  String email;
  String senha;
  bool ativo;
  Noiva noiva;

  Usuario(
      {this.idusuario,
      this.nome,
      this.email,
      this.senha,
      this.ativo,
      this.noiva});

  Usuario.fromJson(Map<String, dynamic> json) {
    idusuario = json['idusuario'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    ativo = json['ativo'];
    noiva = json['noiva'] != null ? new Noiva.fromJson(json['noiva']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusuario'] = this.idusuario;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['ativo'] = this.ativo;
    if (this.noiva != null) {
      data['noiva'] = this.noiva.toJson();
    }
    return data;
  }
}

class Noiva {
  int idnoiva;
  String nome;
  String cpf;
  String fotoPerfil;
  List fotoAlbum;
  List listaPresentes;
  double meta;
  double vlrMeta;
  String tamLin;
  String telefone;
  Evento evento;
  //ListaPresentes listapresentes;

  Noiva({
    this.idnoiva,
    this.nome,
    this.cpf,
    this.fotoPerfil,
    this.fotoAlbum,
    this.listaPresentes,
    this.meta,
    this.vlrMeta,
    this.tamLin,
    this.telefone,
    this.evento,
    /*this.listapresentes*/
  });

  Noiva.fromJson(Map<String, dynamic> json) {
    idnoiva = json['idnoiva'];
    nome = json['nome'];
    cpf = json['cpf'];
    fotoPerfil = json['fotoPerfil'];
    fotoAlbum = json['fotoAlbum'];
    listaPresentes = json['listaPresentes'];
    meta = json['meta'];
    vlrMeta = json['vlrMeta'];
    tamLin = json['tamLin'];
    telefone = json['telefone'];

    evento =
        json['evento'] != null ? new Evento.fromJson(json['evento']) : null;
    /*listapresentes = json['listapresentes'] != null
        ? new ListaPresentes.fromJson(json['listapresentes'])
        : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idnoiva'] = this.idnoiva;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['fotoPerfil'] = this.fotoPerfil;
    data['fotoAlbum'] = this.fotoAlbum;
    data['listaPresentes'] = this.listaPresentes;
    data['meta'] = this.meta;
    data['vlrMeta'] = this.vlrMeta;
    data['tamLin'] = this.tamLin;
    data['telefone'] = this.telefone;

    if (this.evento != null) {
      data['evento'] = this.evento.toJson();
    }
    /*if (this.listapresentes != null) {
      data['listapresentes'] = this.listapresentes.toJson();
    }*/
    return data;
  }
}

/*class ListaPresentes {
  String idlistapresentes;
  int idnoiva;
  String referencia;
  String descricao;
  String tamanho;
  // ignore: non_constant_identifier_names
  double preco_tabela;
  String marca;
  String link;

  ListaPresentes(
      {this.idlistapresentes,
      this.idnoiva,
      this.referencia,
      this.descricao,
      this.tamanho,
      // ignore: non_constant_identifier_names
      this.preco_tabela,
      this.marca,
      this.link});

  ListaPresentes.fromJson(Map<String, dynamic> json) {
    idlistapresentes = json['idlistapresentes'];
    idnoiva = json['idnoiva'];
    referencia = json['referencia'];
    descricao = json['descricao'];
    tamanho = json['tamanho'];
    preco_tabela = json['preco_tabela'];
    marca = json['marca'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idlistapresentes'] = this.idlistapresentes;
    data['idnoiva'] = this.idnoiva;
    data['referencia'] = this.referencia;
    data['descricao'] = this.descricao;
    data['tamanho'] = this.tamanho;
    data['preco_tabela'] = this.preco_tabela;
    data['marca'] = this.marca;
    data['link'] = this.link;
    return data;
  }
}*/

class Evento {
  int idevento;
  int idpessoa;
  String msg;
  String data;
  String hora;
  String cep;
  String uf;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cidade;

  Evento({
    this.idevento,
    this.idpessoa,
    this.msg,
    this.data,
    this.hora,
    this.cep,
    this.uf,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
  });

  Evento.fromJson(Map<String, dynamic> json) {
    idevento = json['idevento'];
    idpessoa = json['idpessoa'];
    msg = json['mensagem'];
    data = json['data'];
    hora = json['hora'];
    cep = json['cep'];
    uf = json['uf'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idevento'] = this.idevento;
    data['idpessoa'] = this.idpessoa;
    data['mensagem'] = this.msg;
    data['data'] = this.data;
    data['hora'] = this.hora;
    data['cep'] = this.cep;
    data['uf'] = this.uf;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    return data;
  }
}
