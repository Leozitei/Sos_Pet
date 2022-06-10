import 'dart:html';

import 'package:flutter/material.dart';

//
// STATEFUL WIDGET
// stf + TAB
class TelaMenu extends StatefulWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'SOS PET',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 26, 3),
      ),
      body: Container(
          color: Color.fromARGB(255, 33, 109, 71),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: const Text(
                  'MENU',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              const SizedBox(height: 40),
               OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(400, 45),
                backgroundColor: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('TODOS OS PETS'),
              onPressed: () {
               Navigator.pushNamed(context, 't7');
              },
            ),
             const SizedBox(height: 40),
             OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(400, 45),
                backgroundColor: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('MEUS PETS'),
              onPressed: () {
               Navigator.pushNamed(context, 't6');
              },
            ),
            const SizedBox(height: 40),
             OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(400, 45),
                backgroundColor: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('CADASTRAR PET'),
              onPressed: () {
               Navigator.pushNamed(context, 't4');
              },
            ),
            const SizedBox(height: 40),
             OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(400, 45),
                backgroundColor: Color.fromARGB(255, 2, 26, 3),
              ),
              child: const Text('SOBRE O SOS PET'),
              onPressed: () {
               Navigator.pushNamed(context, 't5');
              },
            ),
            ],
          )),
    );
  }
}
