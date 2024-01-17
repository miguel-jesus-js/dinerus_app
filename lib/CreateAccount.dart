// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController curp = TextEditingController();
  final TextEditingController rfc = TextEditingController();
  final TextEditingController _banco = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contraena = TextEditingController();
  String path = '';
  String imagen64 = '';
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            children: [
              const Center(child: Text('REGISTRO', style: TextStyle(color: Colors.yellow, fontSize: 30))),
              const SizedBox(height: 20,),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullName,
                        style: const TextStyle(color: Colors.yellow),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow
                            )
                          ),
                          labelText: 'Nombre completo'
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Escribe tu nombre completo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      // TextFormField(
                      //   controller: _curp,
                      //   style: const TextStyle(color: Colors.yellow),
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: Colors.yellow
                      //       )
                      //     ),
                      //     labelText: 'CURP'
                      //   ),
                      //   maxLength: 18,
                      //   validator: (value) {
                      //     if(value!.isEmpty){
                      //       return 'Escribe tu CURP';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(height: 20,),
                      // TextFormField(
                      //   controller: _rfc,
                      //   style: const TextStyle(color: Colors.yellow),
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: Colors.yellow
                      //       )
                      //     ),
                      //     labelText: 'RFC'
                      //   ),
                      //   maxLength: 13,
                      //   validator: (value) {
                      //     if(value!.isEmpty){
                      //       return 'Escribe tu RFC';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(height: 20,),
                      TextFormField(
                        controller: _banco,
                        style: const TextStyle(color: Colors.yellow),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow
                            )
                          ),
                          labelText: 'Banco'
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Escribe el nombre de tu banco';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _accountNumber,
                        style: const TextStyle(color: Colors.yellow),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow
                            )
                          ),
                          labelText: 'Número de cuenta'
                        ),
                        maxLength: 18,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Escribe tu número de cuenta';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20,),
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
                        controller: _contraena,
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
                      // const SizedBox(height: 20,),
                      // TextButton(
                      //   onPressed: () async{
                      //     final ImagePicker picker = ImagePicker();
                      //     final XFile? image = await picker.pickImage(source: ImageSource.camera);
                      //     setState(() {
                      //       path = image!.path;
                      //     });
                      //   },
                      //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                      //   child: const Text('INE FRONTAL', style: TextStyle(color: Colors.black, fontSize: 20))
                      // ),
                      // path == ''
                      //   ? Container()
                      //   : Image.file(
                      //   File(path),
                      //   width: 100,
                      // ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () async{
                          // if(path == ''){
                          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Toma una foto de tu INE')));
                          //   return;
                          // }
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              load = true;
                            });
                            //List<int> bytes = File(path).readAsBytesSync();
                            try{
                              var data = {
                                'full_name': _fullName.text,
                                //'curp': _curp.text,
                                //'rfc': _rfc.text,
                                'bank': _banco.text,
                                'account_number': _accountNumber.text,
                                'email': _correo.text,
                                'pass': _contraena.text,
                                //'img':  base64.encode(bytes)
                              };
                              final response = await http.Client().post(
                                Uri.https('phpstack-585128-4196278.cloudwaysapps.com', '/api/user/create'),
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
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson['message'])));
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }else{
                                  setState(() {
                                    load = false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al crear la cuenta')));
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
                        child: const Text('CREAR CUENTA', style: TextStyle(color: Colors.black, fontSize: 22))
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
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
        ]
      ),
    );
  }
}