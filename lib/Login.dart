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
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _correo = TextEditingController();
    final TextEditingController _password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            children: [
              const Center(child: Text('INICIAR SESIÓN', style: TextStyle(color: Colors.yellow, fontSize: 30))),
              const SizedBox(height: 20,),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _correo,
                        style: const TextStyle(color: Colors.yellow),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow
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
                        controller: _password,
                        style: const TextStyle(color: Colors.yellow),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow
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
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            try{
                              var data = {
                                'email': _correo.text,
                                'password': _password.text,
                              };
                              final response = await http.Client().post(
                                Uri.http('10.0.2.2', '/dinerus/public/api/login'),
                                body: jsonEncode(data),
                                headers: {
                                  'Content-type': 'application/json',
                                  'Accept': 'application/json',
                                  'Charset': 'utf-8'
                                },
                              );
                              if(response.statusCode == 200){
                                Map<String, dynamic> responseJson = jsonDecode(response.body);
                                saveSession(
                                  responseJson['token'],
                                  responseJson['userdata']['email'],
                                  responseJson['userdata'],
                                );
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson['message'])));
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => responseJson['userdata']['paid'] == 0 ? const PaidPage() : const PaidPage(),
                                  ),
                                );
                              }
                            } on SocketException{
                              // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error de servidor')));
                            }
                          }
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                        child: const Text('ACCEDER', style: TextStyle(color: Colors.black, fontSize: 22))
                      ),
                    ],
                  ),
                ),
              ),
            ],
            )
        ),
      );
  }
  
}