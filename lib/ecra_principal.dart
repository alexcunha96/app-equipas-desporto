import 'package:flutter/material.dart';
import 'main.dart';
import 'ecra_login.dart';
import 'painel_gestao.dart';

class EcraPrincipal extends StatefulWidget {
  const EcraPrincipal({super.key});

  @override
  State<EcraPrincipal> createState() => _EcraPrincipalState();
}

class _EcraPrincipalState extends State<EcraPrincipal> {
  String _nomeEquipa = 'Os Ases do Pedal';
  
  final List<Map<String, String>> _membros = [
    {'nome': 'Alex Cunha', 'cargo': 'Dono'},
    {'nome': 'Carlos Silva', 'cargo': 'Admin'},
    {'nome': 'Rita Santos', 'cargo': 'Membro'},
  ];

  final List<Map<String, dynamic>> _atividades = [
    {'id': 1, 'titulo': 'Volta de Ciclismo - Domingo', 'tipo': 'Ciclismo', 'data': '15 Nov - 08:30', 'local': 'Igreja Matriz', 'vou': 5, 'naovou': 1, 'meuVoto': null},
    {'id': 2, 'titulo': 'Corrida Noturna Crónica', 'tipo': 'Corrida', 'data': '18 Nov - 20:00', 'local': 'Estádio Municipal', 'vou': 2, 'naovou': 0, 'meuVoto': null},
  ];

  void _votar(int id, bool vai) {
    setState(() {
      for (var atv in _atividades) {
        if (atv['id'] == id) {
          if (atv['meuVoto'] == vai) return;
          if (atv['meuVoto'] == null) {
            if (vai) atv['vou']++; else atv['naovou']++;
          } else {
            if (vai) { atv['vou']++; atv['naovou']--; } else { atv['vou']--; atv['naovou']++; }
          }
          atv['meuVoto'] = vai;
        }
      }
    });
  }

  void _abrirCriarAtividade() {
    final tituloCtrl = TextEditingController();
    final localCtrl = TextEditingController();
    String tipoEscolhido = 'Ciclismo';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Agendar Nova Volta/Treino', style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: tituloCtrl, decoration: const InputDecoration(labelText: 'Nome da Atividade')),
            TextField(controller: localCtrl, decoration: const InputDecoration(labelText: 'Ponto de Encontro')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (tituloCtrl.text.isNotEmpty) {
                  setState(() {
                    _atividades.add({
                      'id': _atividades.length + 1,
                      'titulo': tituloCtrl.text,
                      'tipo': tipoEscolhido,
                      'data': 'Hoje - À hora marcada',
                      'local': localCtrl.text.isEmpty ? 'Ponto Central' : localCtrl.text,
                      'vou': 1, 'naovou': 0, 'meuVoto': true
                    });
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
              child: const Text('Publicar Agenda para a Equipa'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool temPermissoesAdmin = cargoUtilizadorLogado == 'Dono' || cargoUtilizadorLogado == 'Admin';

    return Scaffold(
      appBar: AppBar(
        title: Text(_nomeEquipa),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          if (temPermissoesAdmin)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => PainelGestao(
                    nomeEquipa: _nomeEquipa,
                    membros: _membros,
                    onNomeAlterado: (novoNome) {
                      setState(() { _nomeEquipa = novoNome; });
                    },
                  ),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EcraLogin())),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cargo: $cargoUtilizadorLogado', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                ElevatedButton.icon(
                  onPressed: _abrirCriarAtividade,
                  icon: const Icon(Icons.add),
                  label: const Text('Nova Volta'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _atividades.length,
                itemBuilder: (context, index) {
                  final atv = _atividades[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(atv['titulo'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('📍 ${atv['local']} | 📅 ${atv['data']}', style: const TextStyle(color: Colors.grey)),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('✅ ${atv['vou']} vão | ❌ ${atv['naovou']} não vão'),
                              Row(
                                children: [
                                  TextButton(onPressed: () => _votar(atv['id'], true), child: Text('Vou', style: TextStyle(color: atv['meuVoto'] == true ? Colors.green : Colors.grey))),
                                  TextButton(onPressed: () => _votar(atv['id'], false), child: Text('Não Vou', style: TextStyle(color: atv['meuVoto'] == false ? Colors.red : Colors.grey))),
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
