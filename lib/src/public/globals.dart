library my_prj.globals;

import 'package:cha_de_lingerie/src/models/UsuarioLembrar.dart';
import 'package:cha_de_lingerie/src/public/ConfigApp.dart';

ConfigApp configApp =
    ConfigApp("cha_de_lingerie", "_cha_de_lingerieServer", true);
UsuarioLembrar usuarioLembrar;
var fotoPerfilN;
var nomeNoiva;
var fotoNoiva;
var emailNoiva;
var fotoDaNoiva;
List listaProdutos;
List normal;
int selectedIndex = 0;
List presentesSel = List();
List filtroLingerie = List();
List listaConvidados;
List listaRecados;
bool lin = false;
bool cam = false;
