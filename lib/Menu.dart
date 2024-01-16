// ignore_for_file: file_names

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
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: const BoxDecoration(color: Colors.black),
            child: Image.asset('assets/img/logo.jpeg'),
          ),
          Column(
            children: [
              const SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                  padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return const EdgeInsets.symmetric(horizontal: 80, vertical: 15);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                child: const Text('CREAR CUENTA', style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              const SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                  padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return const EdgeInsets.symmetric(horizontal: 40, vertical: 15);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                child: const Text('OLVIDÉ MI CONTRASEÑA', style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              const SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                  padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return const EdgeInsets.symmetric(horizontal: 120, vertical: 15);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                child: const Text('INICIAR', style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}