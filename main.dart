import 'package:flutter/material.dart';

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

// ==========================================
// 1. ECRÃ DE LOGIN
// ==========================================
class EcraLogin extends StatefulWidget {
  const EcraLogin({super.key});

  @override
  State<EcraLogin> createState() => _EcraLoginState();
}

class _EcraLoginState extends State<EcraLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          side: corBotao == Colors.white ? const BorderSide(color: Color(0xFFE0E0E0)) : BorderSide.none,
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
                const SizedBox(height: 8),
                const Text(
                  'Pedala, corre, caminha. Juntos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                
                _botaoSocial(
                  texto: 'Entrar com a Apple',
                  icone: Icons.apple,
                  corBotao: Colors.black,
                  corTexto: Colors.white,
                  aoClicar: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
                const SizedBox(height: 10),
                _botaoSocial(
                  texto: 'Entrar com o Google',
                  icone: Icons.g_mobiledata, 
                  corBotao: Colors.white,
                  corTexto: Colors.black87,
                  aoClicar: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
                const SizedBox(height: 10),
                _botaoSocial(
                  texto: 'Entrar com o Facebook',
                  icone: Icons.facebook,
                  corBotao: const Color(0xFF1877F2),
                  corTexto: Colors.white,
                  aoClicar: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                ),
                
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('ou usa o email', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraPrincipal()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Entrar na Equipa', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EcraRegisto()));
                  },
                  child: const Text('Não tens conta? Cria uma aqui'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ==========================================
// 2. ECRÃ DE REGISTO (CRIAR CONTA)
// ==========================================
class EcraRegisto extends StatefulWidget {
  const EcraRegisto({super.key});

  @override
  State<EcraRegisto> createState() => _EcraRegistoState();
}

class _EcraRegistoState extends State<EcraRegisto> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _modalidadeFavorita = 'Ciclismo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Junta-te à tua equipa!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(height: 24),
              const Text('Modalidade Principal:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: _modalidadeFavorita,
                isExpanded: true,
                items: <String>['Ciclismo', 'Corrida', 'Caminhada'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (novoValor) {
                  setState(() {
                    _modalidadeFavorita = novoValor!;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Conta criada com sucesso!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registar e Começar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ==========================================
// 3. ECRÃ PRINCIPAL (CALENDÁRIO E VOTAÇÕES)
// ==========================================
class EcraPrincipal extends StatefulWidget {
  const EcraPrincipal({super.key});

  @override
  State<EcraPrincipal> createState() => _EcraPrincipalState();
}

class _EcraPrincipalState extends State<EcraPrincipal> {
  final List<Map<String, dynamic>> _atividades = [
    {
      'id': 1,
      'titulo': 'Volta de Domingo de Bicicleta',
      'tipo': 'Ciclismo',
      'data': '15 Nov - 08:30',
      'local': 'Estação de Comboios',
      'vou': 5,
      'naovou': 1,
      'meuVoto': null,
    },
    {
      'id': 2,
      'titulo': 'Treino Técnico de Corrida',
      'tipo': 'Corrida',
      'data': '18 Nov - 19:15',
      'local': 'Pista de Atletismo',
      'vou': 3,
      'naovou': 0,
      'meuVoto': null,
    },
    {
      'id': 3,
      'titulo': 'Caminhada na Serra',
      'tipo': 'Caminhada',
      'data': '22 Nov - 09:00',
      'local': 'Parque de Estacionamento Sul',
      'vou': 8,
      'naovou': 2,
      'meuVoto': null,
    }
  ];

  void _votar(int id, bool vai) {
    setState(() {
      for (var atividade in _atividades) {
        if (atividade['id'] == id) {
          if (atividade['meuVoto'] == vai) return;
          if (atividade['meuVoto'] == null) {
            if (vai) atividade['vou']++; else atividade['naovou']++;
          } else {
            if (vai) {
              atividade['vou']++;
              atividade['naovou']--;
            } else {
              atividade['vou']--;
              atividade['naovou']++;
            }
          }
          atividade['meuVoto'] = vai;
        }
      }
    });
  }

  IconData _getIcone(String tipo) {
    if (tipo == 'Ciclismo') return Icons.directions_bike;
    if (tipo == 'Corrida') return Icons.directions_run;
    return Icons.directions_walk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda da Equipa'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraLogin()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Próximas Voltas e Atividades',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _atividades.length,
                itemBuilder: (context, index) {
                  final atividade = _atividades[index];
                  return Card(
                    margin: const EdgeInsets.bottom(16),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(_getIcone(atividade['tipo']), color: Colors.deepOrange, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  atividade['titulo'],
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(atividade['data'], style: const TextStyle(color: Colors.grey)),
                              const SizedBox(width: 16),
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Expanded(child: Text(atividade['local'], style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('✅ ${atividade['vou']} vão', style: const TextStyle(fontWeight: FontWeight.w500)),
                                  const SizedBox(width: 12),
                                  Text('❌ ${atividade['naovou']} não vão', style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _votar(atividade['id'], true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: atividade['meuVoto'] == true ? Colors.green : Colors.grey,
                                      foregroundColor: atividade['meuVoto'] == true ? Colors.white : Colors.black,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    ),
                                    child: const Text('Vou'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _votar(atividade['id'], false),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: atividade['meuVoto'] == false ? Colors.red : Colors.grey,
                                      foregroundColor: atividade['meuVoto'] == false ? Colors.white : Colors.black,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    ),
                                    child: const Text('Não vou'),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
