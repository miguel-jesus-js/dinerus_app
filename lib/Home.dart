import 'package:dinerus_app/Menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bienvenido a dinerus', style: TextStyle(color: Colors.yellow, fontSize: 20), textAlign: TextAlign.start,),
                const SizedBox(height: 15,),
                const Text('La forma más fácil de ganar dinero.', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 15,),
                const Text('Con dinerus solo deberás comprar un turno de \$1,000.00 MX y esperar a recibir la cantidad de \$8,000.00 MX así de fácil.', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 15,),
                const Text('Cumple al 100% los requisitos y recibe los beneficios.', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 30,),
                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
                    },
                    child: const Text('INICIAR', style: TextStyle(color: Colors.yellow, fontSize: 35))
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