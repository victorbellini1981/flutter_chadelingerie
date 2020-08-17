class Usuario {
  int idusuario;
  String email;
  String senha;
  Pessoa pessoa;

  Usuario({this.idusuario, this.email, this.senha, this.pessoa});

  Usuario.fromJson(Map<String, dynamic> json) {
    idusuario = json['idusuario'];
    email = json['email'];
    senha = json['senha'];
    pessoa =
        json['pessoa'] != null ? new Pessoa.fromJson(json['pessoa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idusuario'] = this.idusuario;
    data['email'] = this.email;
    data['senha'] = this.senha;
    if (this.pessoa != null) {
      data['pessoa'] = this.pessoa.toJson();
    }
    return data;
  }
}

class Pessoa {
  int idpessoa;
  int idusuario;
  String nome;
  String email;
  String cpf;
  String fotoPerfil;
  List fotoAlbum;
  String telefone;
  Evento evento;
  //ListaPresentes listapresentes;

  Pessoa({
    this.idpessoa,
    this.idusuario,
    this.nome,
    this.email,
    this.cpf,
    this.fotoPerfil,
    this.fotoAlbum,
    this.telefone,
    this.evento,
    /*this.listapresentes*/
  });

  Pessoa.fromJson(Map<String, dynamic> json) {
    idpessoa = json['idpessoa'];
    idusuario = json['idusuario'];
    nome = json['nome'];
    email = json['email'];
    cpf = json['cpf'];
    fotoPerfil = json['fotoPerfil'];
    fotoAlbum = json['fotoAlbum'];
    telefone = json['telefone'];

    evento =
        json['evento'] != null ? new Evento.fromJson(json['evento']) : null;
    /*listapresentes = json['listapresentes'] != null
        ? new ListaPresentes.fromJson(json['listapresentes'])
        : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpessoa'] = this.idpessoa;
    data['idusuario'] = this.idusuario;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['fotoPerfil'] = this.fotoPerfil;
    data['fotoAlbum'] = this.fotoAlbum;
    data['telefone'] = this.telefone;

    if (this.evento != null) {
      data['evento'] = this.evento.toJson();
    }

    return data;
  }
}

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

class ListaProdutos {
  int idlistaprodutos;
  int idpessoa;
  int idevento;
  List listadepresentes;

  ListaProdutos({
    this.idlistaprodutos,
    this.idpessoa,
    this.idevento,
    this.listadepresentes,
  });

  ListaProdutos.fromJson(Map<String, dynamic> json) {
    idlistaprodutos = json['idlistaprodutos'];
    idpessoa = json['idpessoa'];
    idevento = json['idevento'];
    listadepresentes = json['listadeprodutos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idlistaprodutos'] = this.idlistaprodutos;
    data['idpessoa'] = this.idpessoa;
    data['idevento'] = this.idevento;
    data['listadepresentes'] = this.listadepresentes;

    return data;
  }
}
