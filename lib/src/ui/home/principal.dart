import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/models/Produtos.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/home/convidados.dart';
import 'package:cha_de_lingerie/src/ui/home/inicial.dart';
import 'package:cha_de_lingerie/src/ui/home/lingeries.dart';
import 'package:cha_de_lingerie/src/ui/home/perfil.dart';
import 'package:cha_de_lingerie/src/ui/home/presentes.dart';
import 'package:cha_de_lingerie/src/ui/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final List<Widget> _widgetOptions = [
    Inicial(),
    Presentes(),
    Lingeries(),
    Convidados()
  ];

  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

  void _onItemTapped(int index) {
    listaProdutos = normal;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          color: Colors.red,
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Perfil()));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' Editar Perfil',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.backspace,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' Sair',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Chá de lingerie",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        actions: <Widget>[
          PopupMenuButton(
            color: Colors.red,
            icon: Image.asset('assets/images/filtro.png'),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildAboutDialog(context),
                      );
                    },
                    child: Text(
                      ' Tamanho',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      lin = true;
                      if (cam == true) {
                        listaProdutos = normal;
                        print('${listaProdutos[2].descricao}');
                      }
                      filtroLingerie = [];
                      for (int i = 0; i < listaProdutos.length; i++) {
                        if (listaProdutos[i].descricao.contains('Lingerie')) {
                          Produtos prod = Produtos();
                          prod.link = '${listaProdutos[i].link}';
                          prod.descricao = '${listaProdutos[i].descricao}';
                          prod.preco_tabela =
                              double.parse('${listaProdutos[i].preco_tabela}');
                          filtroLingerie.add(prod);
                        }
                      }
                      listaProdutos = filtroLingerie;
                      selectedIndex = 2;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Principal()));
                    },
                    child: Text(
                      ' Lingeries',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      cam = true;

                      if (lin == true) {
                        listaProdutos = normal;
                      }
                      filtroLingerie = [];
                      for (int i = 0; i < listaProdutos.length; i++) {
                        if (listaProdutos[i].descricao.contains('Camisola')) {
                          Produtos prod = Produtos();
                          prod.link = '${listaProdutos[i].link}';
                          prod.descricao = '${listaProdutos[i].descricao}';
                          prod.preco_tabela =
                              double.parse('${listaProdutos[i].preco_tabela}');
                          filtroLingerie.add(prod);
                        }
                      }
                      listaProdutos = filtroLingerie;
                      selectedIndex = 2;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Principal()));
                    },
                    child: Text(
                      ' Camisolas',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Página Inicial'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Lista de Presentes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Adicionar Lingeries'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Convidados'),
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  var tam;
  var selecttam = 'T';

  Widget _buildAboutDialog(BuildContext context) {
    void tamanhos() {
      /*
      filtroLingerie = [];
      for (int i = 0; i < listaProdutos.length; i++) {
        for (int j = 0; j < listaProdutos[i].tamanhos.length)
        if (listaProdutos[i].tamanhos[j] == selecttam {
          Produtos prod = Produtos();
          prod.link = '${listaProdutos[i].link}';
          prod.descricao = '${listaProdutos[i].descricao}';
          prod.tamanho = selecttam;
          prod.preco_tabela = double.parse('${listaProdutos[i].preco_tabela}');
          filtroLingerie.add(prod);
        }
      }
      listaProdutos = filtroLingerie;*/
      selectedIndex = 2;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
    }

    final tamLin = Wrap(
      children: <Widget>[
        Row(
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
                        tamanhos();
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
                        tamanhos();
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
                        tamanhos();
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
                        tamanhos();
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
                        tamanhos();
                      }),
                  Text(
                    'GG',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
    return new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        title: const Text('Selecione o tamanho'),
        content: Container(
          width: 300,
          child: tamLin,
        ));
  }
}
