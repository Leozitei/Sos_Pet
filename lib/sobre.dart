import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagens.dart';

class Sobre extends StatelessWidget {
  
  const Sobre({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('SOS PET'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 2, 26, 3)),
      backgroundColor: Color.fromARGB(255, 33, 109, 71),
      body: Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 100),
      decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 33, 109, 71),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 550,
      child: Column(
        children: [
          Text('SOS PET', style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 255, 255, 255)),),
          const SizedBox(height: 40),
          Text('A iniciativa da construção do software é interconectar pets para a adoção com seus possíveis donos. A adoção é capaz de salvar a vida de um animal que poderia estar nas ruas, abandonado, faminto e possivelmente sofrendo de maus tratos.'
'Segundo a Sociedade Mineira Protetora dos Animais (SMPA), hoje no Brasil existem cerca de 300 milhões de pets, em sua maioria cães e gatos, abandonados nas ruas. Com esse cenário surgem ONGs ou até mesmo simpatizantes da causa animal, que os resgatam das ruas e oferecem abrigo temporário. Porém muitas vezes por falta de recursos e grande número de animais eles acabam não resistindo. Tendo esta percepção é necessária uma maneira para que os pets encontrem um novo lar de forma mais rápida possível.'
'O aplicativo se propõe para ser uma nova ferramenta, moderna, que irá dar visibilidade no mundo digital para a causa. De maneira simples os pets serão publicados para a adoção e um possível dono poderá entrar em contato sem sair de casa.'
'Ele irá unir quem está doando os pets a quem está buscando um, de maneira remota e virtual.', style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 255, 255, 255)),),
           const SizedBox(height: 20),
          const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: const Text('Voltar'),
                      onPressed: () {
                         Navigator.pushNamed(context, 't2');
                      }),
                ),
        ],
        
      ),
      
    ),
    
    );
    
  }

 
  }




