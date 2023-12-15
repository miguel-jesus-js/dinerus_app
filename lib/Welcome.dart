import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Image.asset('assets/img/logo.jpeg'),
            const SizedBox(height: 50,),
            const Column(
              children: [
                Center(
                  child: Text('BIENVENIDO', style: TextStyle(color: Colors.yellow, fontSize: 22)),
                ),
              ],
            )
          ]
          ),
      ),
    );
  }
}