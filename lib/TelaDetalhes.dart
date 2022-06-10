import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagens.dart';

class DetalhesPet extends StatefulWidget {
  const DetalhesPet({Key? key}) : super(key: key);

  @override
  DetalhesPetState createState() => DetalhesPetState();
}

class DetalhesPetState extends State<DetalhesPet> {
  var txtNome = TextEditingController();
  var txtAnimal = TextEditingController();
  var txtDescricao = TextEditingController();
  var txtCidade = TextEditingController();

  //Retonar um documento pelo ID
  retornarDocumentoById(id) async{
    await FirebaseFirestore.instance
      .collection('pets')
      .doc(id)
      .get()
      .then((doc){
        txtNome.text = doc.get('nome');
        txtAnimal.text = doc.get('animal');
        txtCidade.text = doc.get('cidade');
        txtDescricao.text = doc.get('descricao');
      });
  }

  @override
  Widget build(BuildContext context) {

    //Recuperar o id do pet
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id!=null){
      if (txtNome.text.isEmpty && txtAnimal.text.isEmpty){
        retornarDocumentoById(id);
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS PET'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 2, 26, 3),
      ),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            CampoDetails('Nome', txtNome.text),
            const SizedBox(height: 20),
            CampoDetails('Animal', txtAnimal.text),
            const SizedBox(height: 20),
            CampoDetails('Cidade', txtCidade.text),
            const SizedBox(height: 20),
            CampoDetails('Descrição', txtDescricao.text),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary:Color.fromARGB(255, 33, 109, 71),
                    ),
                    child: const Text('Entrar em contato'),
                    onPressed: () {                      
                        
                      sucesso(context,'Uma mensagem foi enviada !');
                      

                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromARGB(255, 33, 109, 71),
                      ),
                      child: const Text('cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  CampoDetails(texto, pet) {
    return Row(     
      
          children: [         

            Text(texto + " : "),
            Text(pet),
          ],
        
    );
  }
}
