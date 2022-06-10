
import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sos_pet/TelaMenu.dart';
import 'package:sos_pet/sobre.dart';
import 'package:sos_pet/MeusPets.dart';
import 'TelaDetalhes.dart';
import 'TelaLogin.dart';
import 'TodosPets.dart';
import 'cadastrar_pet.dart';
import 'criar_conta.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOS PET',
      initialRoute: 't1',
      routes: {
        't1' : (context) => const TelaLogin(),
        't2' : (context) => const TelaMenu(),
        't3' : (context) => const CriarContaPage(),
        't4' : (context) => const InserirPet(),
        't5' : (context) => const Sobre(),
        't6' : (context) => const MeusPets(),
        't7' : (context) => const TodosPets(),
        't8' : (context) => const DetalhesPet()
      },
    )
  );
}