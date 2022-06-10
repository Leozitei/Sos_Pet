import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagens.dart';



class TodosPets extends StatefulWidget {
  const TodosPets({Key? key}) : super(key: key);

  @override
  TodosPetsState createState() => TodosPetsState();
}

class TodosPetsState extends State<TodosPets> {
 
  var pets;
  var nomeUsuario;

  @override
  void initState() {
    super.initState();
    pets = FirebaseFirestore.instance
        .collection('pets')
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Pet'),
        centerTitle: true,
        backgroundColor:Color.fromARGB(255, 2, 26, 3),
        automaticallyImplyLeading: false,
        actions: [
          Column(
            children: [
              IconButton(
                tooltip: 'sair',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, 't1');
                },
                icon: const Icon(Icons.logout),
              ),

              
              FutureBuilder(
                future: retornarUsuarioLogado(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    
                    return const Expanded(child: CircularProgressIndicator());
                  } else {
                    return Text(
                        nomeUsuario ?? '',
                        style: const TextStyle(fontSize: 12),
                      );                    
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        
        child: StreamBuilder<QuerySnapshot>(
          
          stream: pets.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text('Não foi possível conectar.'));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                  itemCount: dados.size,
                  itemBuilder: (context, index) {
                    return exibirDocumento(dados.docs[index]);
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 2, 26, 3),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 't4');
        },
      ),
    );
  }

  exibirDocumento(item) {
    String nome = item.data()['nome'];
    String animal = item.data()['animal'];    
    return ListTile(
      title: Text(nome),
      subtitle: Text(animal),      

      
      trailing: IconButton(
        icon: const Icon(Icons.details),
        onPressed: () {
          
         Navigator.pushNamed(
          context,
          't8',
          arguments: item.id,
        
        );
        },
      ),     
     
    );
  }

  retornarUsuarioLogado() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .get()
        .then((q) {
      if (q.docs.isNotEmpty) {
        nomeUsuario = q.docs[0].data()['nome'];
      } else {
        nomeUsuario = "NENHUM";
      }
    });
  }
}
