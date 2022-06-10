import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagens.dart';

class InserirPet extends StatefulWidget {
  const InserirPet({Key? key}) : super(key: key);

  @override
  _InserirPetState createState() => _InserirPetState();
}

class _InserirPetState extends State<InserirPet> {
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
            campoTexto('Nome', txtNome, Icons.auto_fix_normal),
            const SizedBox(height: 20),
            campoTexto('Animal', txtAnimal, Icons.pets),
            const SizedBox(height: 20),
            campoTexto('Cidade', txtCidade, Icons.location_city),
            const SizedBox(height: 20),
            campoTexto('Descrição', txtDescricao, Icons.description),
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
                    child: const Text('salvar'),
                    onPressed: () {

                      if ( id == null){
                        //Adicionar um novo documento
                        FirebaseFirestore.instance
                          .collection('pets')
                          .add(
                            {
                              "uid" : FirebaseAuth.instance.currentUser!.uid,
                              "nome" : txtNome.text,
                              "animal": txtAnimal.text,
                              "cidade" : txtCidade.text,
                              "descricao" : txtDescricao.text,
                            }
                          );
                        sucesso(context,'Item adicionado com sucesso.');
                      }else{
                        FirebaseFirestore.instance
                          .collection('pets')
                          .doc(id.toString())
                          .set(
                            {
                              "uid" : FirebaseAuth.instance.currentUser!.uid,
                              "nome" : txtNome.text,
                              "animal": txtAnimal.text,
                              "cidade": txtCidade.text,
                              "descricao": txtDescricao.text,
                            }
                          );
                          sucesso(context,'Item alterado com sucesso.');
                      }

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

  campoTexto(texto, controller, icone, {senha}) {
    return TextField(
      controller: controller,
      obscureText: senha != null ? true : false,
      style: const TextStyle(
        color: Color.fromARGB(255, 33, 109, 71),
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icone, color:Color.fromARGB(255, 33, 109, 71)),
        prefixIconColor: Color.fromARGB(255, 33, 109, 71),
        labelText: texto,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 33, 109, 71)),
        border: const OutlineInputBorder(),
        focusColor: Color.fromARGB(255, 33, 109, 71),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 33, 109, 71),
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
