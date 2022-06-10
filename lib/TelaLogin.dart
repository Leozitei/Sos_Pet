import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sos_pet/widgets/mensagens.dart';

//
// STATEFUL WIDGET
// stf + TAB
class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  //Declaração dos atributos que serão usados para
  //armazenar os dados informados pelo usuário
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;

  //Declaração de um atributo que identifica unicamento um formulario
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        title: const Text('Café Store'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 2, 26, 3),
        
      ),
      
      backgroundColor: Color.fromARGB(255, 33, 109, 71),
      body: Container(
        padding: const EdgeInsets.all(50),
        
        child: ListView(
          children: [
            Column(
                      children: [
                        const SizedBox(height: 30),
                        Image.asset(
                          'lib/imagens/dogLogo.png',
                          scale: 5.0,
                        ),
                        const Text(
                          'SOS PET',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
            campoTexto('Email', txtEmail, Icons.email),
            const SizedBox(height: 20),
            campoTexto('Senha', txtSenha, Icons.lock, senha: true),
            TextButton(onPressed: (){}, child: const Text('Esqueceu a senha?', textAlign: TextAlign.end,)),
            const SizedBox(height: 40),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(200, 45),
                backgroundColor: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('entrar'),
              onPressed: () {
                login(txtEmail.text, txtSenha.text);
              },
            ),
            const SizedBox(height: 50),
            TextButton(
              style: OutlinedButton.styleFrom(
                primary: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('Criar conta'),
              onPressed: () {
                Navigator.pushNamed(context, 't3');
              },
            ),
          ],
        ),
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
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
  //Caixa de dialogo

  void login(email, senha) {
    FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: senha)
    .then((res){
      sucesso(context, 'Usuário autenticado com sucesso.');
      Navigator.pushReplacementNamed(context, 't2');
    }).catchError((e){
      switch(e.code){
        case 'invalid-email':
          erro(context,'O formato do email é inválido.');
          break;
        case 'user-not-found':
          erro(context,'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context,'Senha incorreta.');
          break;
        default:
          erro(context,e.code.toString());
      }
   });
   }
}

