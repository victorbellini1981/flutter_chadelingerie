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

class _PrincipalState extends State<Principal>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> _widgetOptions = [
    Inicial(),
    Presentes(),
    Lingeries(),
    Convidados()
  ];

  TabController controller;

  @override
  void initState() {
    super.initState();
    // controlador das telas da navbar
    controller = TabController(length: _widgetOptions.length, vsync: this);
    controller.animateTo(selectedIndex);
    getUrlServidor();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // btao menu do lado esquerdo da tela, editar perfil e sair
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
                  selectedIndex = 0;
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
                  selectedIndex = 0;
                  selecttam = 'T';
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
        // botao filtro do lado direito da tela com filtro de tamanho, lingeries e camisolas
        actions: <Widget>[
          PopupMenuButton(
            color: Colors.red,
            icon: Image.asset('assets/images/filtro.png'),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        // chama um pop-up para noiva selecionar o tamanho da lingerie
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
                      // carrega somente lingeries na lista
                      lin =
                          true; // variável ativada pra qdo entrar na lista de camisolas
                      //forçar a lista de produtos voltar pra lista com todos os produtos
                      if (cam == true) {
                        listaProdutos = normal;
                      }
                      cam = false;
                      filtroLingerie = [];
                      for (int i = 0; i < listaProdutos.length; i++) {
                        if (listaProdutos[i].descricao.contains('Lingerie')) {
                          Produtos prod = Produtos();
                          prod.link = '${listaProdutos[i].link}';
                          prod.referencia = '${listaProdutos[i].referencia}';
                          prod.descricao = '${listaProdutos[i].descricao}';
                          prod.tamanhos = '${listaProdutos[i].tamanhos}';
                          prod.marca = '${listaProdutos[i].marca}';
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
                      // função pra carregar somente camisolas na lista
                      cam =
                          true; // variável ativada pra qdo entrar na lista de lingeries
                      //forçar a lista de produtos voltar pra lista com todos os produtos
                      if (lin == true) {
                        listaProdutos = normal;
                      }
                      lin = false;
                      filtroLingerie = [];
                      for (int i = 0; i < listaProdutos.length; i++) {
                        if (listaProdutos[i].descricao.contains('Camisola')) {
                          Produtos prod = Produtos();
                          prod.link = '${listaProdutos[i].link}';
                          prod.referencia = '${listaProdutos[i].referencia}';
                          prod.descricao = '${listaProdutos[i].descricao}';
                          prod.tamanhos = '${listaProdutos[i].tamanhos}';
                          prod.marca = '${listaProdutos[i].marca}';
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
      body: TabBarView(
        // controla a visualização das telas conforme muda na navbar
        controller: controller,
        children: _widgetOptions,
      ),
      /*Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),*/
      bottomNavigationBar: new TabBar(
        // icones das telas na navbar
        tabs: [
          Tab(
            icon: new Icon(Icons.home),
            text: 'Inicial',
          ),
          Tab(
            icon: new Icon(Icons.list),
            text: 'Presentes',
          ),
          Tab(
            icon: new Icon(Icons.add),
            text: 'Lingeries',
          ),
          Tab(
            icon: new Icon(Icons.group),
            text: 'Convidados',
          )
        ],
        labelColor: Colors.red,
        unselectedLabelColor: Colors.black,
        labelPadding: EdgeInsets.all(0.0),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.red,
        controller: controller,
      ),
      /* bottomNavigationBar: BottomNavigationBar(
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
        onTap: (currentIndex) {
          listaProdutos = normal;
          setState(() {
            selectedIndex = currentIndex;
          });
          controller.animateTo(selectedIndex);
        },
      ),*/
    );
  }

//retorna o pop-up com os tamanhos
  var tam;
  var tamanhosP = '';
  List tamsLingerie = List();
  List tamanhosProd = List();

  Widget _buildAboutDialog(BuildContext context) {
    void tamanhos() {
      if (cam == false && lin == false) {
        listaProdutos = normal;
      }
      filtroLingerie = [];
      for (int i = 0; i < listaProdutos.length; i++) {
        tamsLingerie = [];
        tamanhosProd = [];
        tamanhosP = listaProdutos[i].tamanhos;
        tamanhosP = tamanhosP.replaceAll("{", "");
        tamanhosP = tamanhosP.replaceAll("}", "");
        tamsLingerie = tamanhosP.split(',');
        for (int j = 0; j < tamsLingerie.length; j++) {
          if (tamsLingerie[j] == selecttam) {
            Produtos prod = Produtos();
            prod.link = '${listaProdutos[i].link}';
            prod.referencia = '${listaProdutos[i].referencia}';
            prod.descricao = '${listaProdutos[i].descricao}';
            prod.tamanhos = '${listaProdutos[i].tamanhos}';
            prod.marca = '${listaProdutos[i].marca}';
            prod.preco_tabela =
                double.parse('${listaProdutos[i].preco_tabela}');
            filtroLingerie.add(prod);
            break;
          }
        }
      }

      listaProdutos = filtroLingerie;
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
