import 'package:flutter/material.dart';
import 'main.dart';
import 'ecra_principal.dart';

class EcraLogin extends StatefulWidget {
  const EcraLogin({super.key});

  @override
  State<EcraLogin> createState() => _EcraLoginState();
}

class _EcraLoginState extends State<EcraLogin> {
  Widget _botaoSocial({
    required String texto, 
    required IconData icone, 
    required Color corBotao, 
    required Color corTexto, 
    required VoidCallback aoClicar
  }) {
    return ElevatedButton.icon(
      onPressed: aoClicar,
      icon: Icon(icone, color: corTexto, size: 20),
      label: Text(texto, style: TextStyle(color: corTexto, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: corBotao,
        elevation: 1,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.directions_bike, size: 80, color: Colors.deepOrange),
                const SizedBox(height: 16),
                const Text(
                  'SportTeam Connect',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Entrar como (Simulação de Testes):',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _botaoSocial(
                  texto: 'Entrar como Administrador Principal 👑',
                  icone: Icons.star,
                  corBotao: Colors.indigo,
                  corTexto: Colors.white,
                  aoClicar: () {
                    cargoUtilizadorLogado = 'Dono';
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
                const SizedBox(height: 12),
                _botaoSocial(
                  texto: 'Entrar como Admin Adjunto 🛡️',
                  icone: Icons.security,
                  corBotao: Colors.blueGrey,
                  corTexto: Colors.white,
                  aoClicar: () {
                    cargoUtilizadorLogado = 'Admin';
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
                const SizedBox(height: 12),
                _botaoSocial(
                  texto: 'Entrar como Membro da Equipa 🚴',
                  icone: Icons.directions_run,
                  corBotao: Colors.deepOrange,
                  corTexto: Colors.white,
                  aoClicar: () {
                    cargoUtilizadorLogado = 'Membro';
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
