import 'package:dinerus_app/CreateAccount.dart';
import 'package:dinerus_app/Login.dart';
import 'package:dinerus_app/ResetPassword.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage()));
                  },
                  child: const Text('CREAR CUENTA', style: TextStyle(color: Colors.yellow, fontSize: 20))
                ),
                const SizedBox(height: 15,),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
                  },
                  child: const Text('OLVIDÉ MI CONTRASEÑA', style: TextStyle(color: Colors.yellow, fontSize: 20))
                ),
                const SizedBox(height: 15,),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: const Text('INICIAR', style: TextStyle(color: Colors.yellow, fontSize: 35))
                ),
              ],
            )
          ]
          ),
      ),
    );
  }
}