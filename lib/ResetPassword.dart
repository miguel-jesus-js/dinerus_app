import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            children: [
              Image.asset('assets/img/logo.jpeg'),
              const SizedBox(height: 50,),
              const Center(child: Text('RECUPERAR CONTRASEÑA', style: TextStyle(color: Colors.yellow, fontSize: 30))),
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
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){

                            try{
                              var data = {
                                'email': _correo.text,
                              };
                              final response = await http.Client().post(
                                Uri.http('10.0.2.2', '/dinerus/public/api/reset-password'),
                                body: jsonEncode(data),
                                headers: {
                                  'Content-type': 'application/json',
                                  'Accept': 'application/json',
                                  'Charset': 'utf-8'
                                },
                              );
                              if(response.statusCode == 200){
                                Map<String, dynamic> responseJson = jsonDecode(response.body);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson['message'])));
                              }
                            } on SocketException{
                              // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error de servidor')));
                            }
                          }
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                        child: const Text('RESTAURAR', style: TextStyle(color: Colors.black, fontSize: 22))
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