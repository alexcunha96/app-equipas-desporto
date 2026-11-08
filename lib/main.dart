import 'package:flutter/material.dart';
import 'ecra_login.dart';

void main() {
  runApp(const AppEquipaDesporto());
}

class AppEquipaDesporto extends StatelessWidget {
  const AppEquipaDesporto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportTeam Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const EcraLogin(),
    );
  }
}

// Variável Global temporária para simulação de testes de permissões
String cargoUtilizadorLogado = 'Membro'; 
