// ignore_for_file: file_names

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
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Stack(
        children: [
          Container(
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
                              setState(() {
                                load = true;
                              });
                              try{
                                var data = {
                                  'email': _correo.text,
                                };
                                final response = await http.Client().post(
                                  Uri.https('phpstack-585128-4196278.cloudwaysapps.com', '/api/reset-password'),
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
                                    setState(() {
                                      load = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson['text'])));
                                  }else{
                                    setState(() {
                                      load = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al restaurar la contraseña')));
                                  }
                                  
                                }else{
                                  setState(() {
                                    load = false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocurrio un error')));
                                }
                              } on SocketException{
                                setState(() {
                                  load = false;
                                });
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
          load ?
          Positioned(
            child: Opacity(
              opacity: 0.4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey
                ),
                height: MediaQuery.of(context).size.height * 1,
                child: const LinearProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          ) :
          Container(),
        ],
      ),
    );
  }
}