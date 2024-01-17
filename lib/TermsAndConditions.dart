// ignore_for_file: file_names

import 'package:dinerus_app/Welcome.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Image.asset('assets/img/logo.jpeg'),
            const SizedBox(height: 50,),
            Column(
              children: [
                const Text('TERMINOS Y CONDICIONES', style: TextStyle(color: Colors.yellow, fontSize: 22)),
                const SizedBox(height: 50,),

                const SizedBox(height: 50,),
                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
                    },
                    child: const Text('ACEPTAR Y CONTINUAR', style: TextStyle(color: Colors.yellow, fontSize: 25))
                  ),
                )
              ],
            )
          ]
          ),
      ),
    );
  }
}