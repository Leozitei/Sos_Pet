import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagens.dart';

class CriarContaPage extends StatefulWidget {
  const CriarContaPage({Key? key}) : super(key: key);

  @override
  _CriarContaPageState createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('SOS PET'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 2, 26, 3)),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            campoTexto('Nome', txtNome, Icons.people),
            const SizedBox(height: 20),
            campoTexto('Email', txtEmail, Icons.email),
            const SizedBox(height: 20),
            campoTexto('Senha', txtSenha, Icons.lock, senha: true),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(200, 45),
                      backgroundColor: Color.fromARGB(255, 2, 26, 3),
                    ),
                    child: const Text('criar'),
                    onPressed: () {
                      criarConta(txtNome.text, txtEmail.text, txtSenha.text);
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(200, 45),
                      backgroundColor: Color.fromARGB(255, 2, 26, 3),
                    ),
                    child: const Text('cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
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
        color: Color.fromARGB(255, 2, 26, 3),
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icone, color: Color.fromARGB(255, 2, 26, 3),),
        prefixIconColor: Color.fromARGB(255, 2, 26, 3),
        labelText: texto,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 2, 26, 3),),
        border: const OutlineInputBorder(),
        focusColor: Color.fromARGB(255, 2, 26, 3),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 2, 26, 3),
            width: 0.0,
          ),
        ),
      ),
    );
  }

  //
  // CRIAR CONTA no Firebase Auth
  //
  void criarConta(nome, email, senha) {
    FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: senha)
      .then((res){

        //Armazenar o nome no Firestore
        FirebaseFirestore.instance.collection('usuarios')
          .add(
            {
              "uid" : res.user!.uid.toString(),
              "nome" : nome,
            }
          );


        sucesso(context,'Usu??rio criado com sucesso.');
        Navigator.pop(context);
      }).catchError((e){
        switch(e.code){
          case 'email-already-in-use':
            erro(context,'O email j?? foi cadastrado.');
            break;
          case 'invalid-email':
            erro(context,'O email ?? inv??lido.');
            break;
          default:
            erro(context, e.code.toString());
        }
      });
  }

}


