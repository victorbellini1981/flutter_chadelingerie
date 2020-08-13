/*        Pessoa noiva = Pessoa();
            noiva.fotoPerfil = fotoPerfilN;
            noiva.fotoAlbum = fotoAlbumN;
            noiva.nome = nomeN;
            noiva.cpf = cpfN;
            noiva.telefone = telN;
            noiva.valorCompras = valorCompras;
            List presentes = List();
            for (int i = 0; i < listaProduto.length; i++) {
              if (opcao[i] == true) {
                Produtos prod = Produtos();
                prod.idproduto = '${listaProduto[i].idproduto}';
                prod.referencia = '${listaProduto[i].referencia}';
                prod.descricao = '${listaProduto[i].descricao}';
                prod.tamanhoLingerie = selectTam;
                prod.preco_tabela =
                    double.parse('${listaProduto[i].preco_tabela}');
                meta = meta + prod.preco_tabela;
                prod.marca = '${listaProduto[i].marca}';
                prod.link = '${listaProduto[i].link}';
                presentes.add(prod);
              }
            }
            noiva.listaPresentes = presentes;
            noiva.meta = meta;

            Evento evento = Evento();
            evento.msg = txtmensagem.text;
            evento.data = txtdata.text;
            evento.hora = txthora.text;
            evento.cep = txtcep.text;
            evento.uf = txtestado.text;
            evento.logradouro = txtlogradouro.text;
            evento.numero = txtnumero.text;
            evento.complemento = txtcomplemento.text;
            evento.bairro = txtbairro.text;
            evento.cidade = txtcidade.text;
            print(noiva.meta);
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Dados salvos com sucesso!'),
              duration: Duration(seconds: 3),
            ));*/

/*
var tam;
var selecttam = 'T';

final tamLin = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'PP',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'PP';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'PP',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'P',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'P';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'P',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'M',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'M';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'M',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'G',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'G';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'G',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'GG',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'GG';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'GG',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );

Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            'https://scontent.fvag3-1.fna.fbcdn.net/v/t1.0-9/20727994_1401203359974779_7391463482417964687_n.jpg?_nc_cat=107&_nc_sid=85a577&_nc_eui2=AeGMPLkEQHbtyR46sckdkToqJ-DOa70fbWMn4M5rvR9tY7-bGVx2M2LFhbDFb6D4Q-AhrOD4-N1zhATvki0EeVNa&_nc_ohc=AT_srjnKhX4AX96c_RQ&_nc_ht=scontent.fvag3-1.fna&oh=9440de3679fab931944872e2036d03c0&oe=5F59DC9B',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${listaConvidados[index]}',
                        style: TextStyle(color: Colors.red, fontSize: 25)),
                    Row(
                      children: <Widget>[],
                    )
                  ],
                );
*/
