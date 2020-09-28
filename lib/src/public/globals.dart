library my_prj.globals;

import 'package:cha_de_lingerie/src/models/UsuarioLembrar.dart';
import 'package:cha_de_lingerie/src/public/ConfigApp.dart';

ConfigApp configApp =
    ConfigApp("cha_de_lingerie", "_cha_de_lingerieServer", true);
UsuarioLembrar usuarioLembrar;
// variáveis que trazem os dados da noiva
var fotoPerfilN;
var idNoiva;
var nomeNoiva;
var fotoNoiva;
var emailNoiva;
var fotoDaNoiva;
// listas de produtos vindos do servidor
List listaProdutos;
List normal;
int selectedIndex =
    0; // variavel que indica o index da tela que vai abrir no corpo da tela principal
List presentesSel = List(); // lista das lingerie selecionadas pela noiva
List filtroLingerie =
    List(); // lista que retorna resultados dos filtros escolhidos
List listaConvidados;
List listaRecados;
// variáveis de verificação se o filtro lingerie e o filtrocamisolas foram utilizados
bool lin = false;
bool cam = false;
// variável que a noiva escolhe o tamanho da lingerie que ela quer pequisar
var selecttam = 'T';
// variável que marca a lingerie que o cliente escolheu para adicionar em sua lista
List<bool> opcao = new List<bool>();
List<bool> opcao2 = List<bool>();
var editar = false; // verifica se vai alterar ou salvar os dados do perfil
