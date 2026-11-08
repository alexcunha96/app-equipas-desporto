import 'package:flutter/material.dart';
import 'main.dart';

class PainelGestao extends StatefulWidget {
  final String nomeEquipa;
  final List<Map<String, String>> membros;
  final Function(String) onNomeAlterado;

  const PainelGestao({
    super.key,
    required this.nomeEquipa,
    required this.membros,
    required this.onNomeAlterado,
  });

  @override
  State<PainelGestao> createState() => _PainelGestaoState();
}

class _PainelGestaoState extends State<PainelGestao> {
  late TextEditingController _nomeCtrl;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.nomeEquipa);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Painel de Controlo Administrativo 👑', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            TextField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(labelText: 'Mudar Nome da Equipa', prefixIcon: Icon(Icons.edit)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                widget.onNomeAlterado(_nomeCtrl.text);
                Navigator.pop(context);
              },
              child: const Text('Guardar Definições'),
            ),
            const SizedBox(height: 20),
            const Text('Gerir Membros da Equipa:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...widget.membros.map((membro) {
              bool eDono = membro['cargo'] == 'Dono';
              bool eAdmin = membro['cargo'] == 'Admin';
              
              return ListTile(
                title: Text(membro['nome']!),
                subtitle: Text('Cargo atual: ${membro['cargo']}'),
                trailing: cargoUtilizadorLogado == 'Dono' && !eDono 
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          membro['cargo'] = eAdmin ? 'Membro' : 'Admin';
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: eAdmin ? Colors.grey : Colors.blueGrey),
                      child: Text(eAdmin ? 'Despromover' : 'Tornar Admin'),
                    )
                  : null,
              );
            }).toList(),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link de convite para a equipa copiado!')));
              },
              icon: const Icon(Icons.share),
              label: const Text('Convidar Novos Membros'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
