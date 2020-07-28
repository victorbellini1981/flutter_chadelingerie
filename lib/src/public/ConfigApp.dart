class ConfigApp {
  String nomeApp = "";
  bool teste = false;
  String urlServidor = "";
  String servlet = "";

  ConfigApp(String nomeApp, String servlet, bool teste) {
    this.nomeApp = nomeApp;
    this.servlet = servlet;
    this.teste = teste;
  }
}