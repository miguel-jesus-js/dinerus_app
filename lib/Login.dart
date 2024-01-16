// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:dinerus_app/Paid.dart';
import 'package:dinerus_app/models/Session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController correo = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/img/logo.jpeg'),
                  const SizedBox(height: 30,),
                  const Text('INICIO DE SESIÓN', style: TextStyle(color: Colors.white, fontSize: 30), textAlign: TextAlign.start,),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: correo,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          ),
                          labelText: 'Correo'
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Escribe tu correo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: password,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          ),
                          labelText: 'Contraseña'
                        ),
                        obscureText: true,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Escribe tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            try{
                              var data = {
                                'email': correo.text,
                                'password': password.text,
                              };
                              final response = await http.Client().post(
                                Uri.https('phpstack-585128-4196278.cloudwaysapps.com', '/api/login'),
                                body: jsonEncode(data),
                                headers: {
                                  'Content-type': 'application/json',
                                  'Accept': 'application/json',
                                  'Charset': 'utf-8'
                                },
                              );
                              if(response.statusCode == 200){
                                Map<String, dynamic> responseJson = jsonDecode(response.body);
                                if(responseJson['type'] == 'success'){
                                  saveSession(
                                    responseJson['token'],
                                    responseJson['userdata']
                                  );
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson['message'])));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaidPage()));
                                }else{
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al iniciar sesión')));
                                }
                                
                              }else{
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocurrio un error')));
                              }
                            } on SocketException{
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error de servidor')));
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                          padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                            return const EdgeInsets.symmetric(horizontal: 100, vertical: 10);
                          }),
                        ),
                        child: const Text('ACCEDER', style: TextStyle(color: Colors.black, fontSize: 22))
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
}