import 'dart:convert';
import 'dart:io';

import 'package:dinerus_app/Confirmation.dart';
import 'package:dinerus_app/models/Session.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PaidPage extends StatefulWidget {
  const PaidPage({super.key});

  @override
  State<PaidPage> createState() => _PaidPageState();
}

class _PaidPageState extends State<PaidPage> {
  String path = '';
  String imagen64 = '';
  Map<String, dynamic> session = {};
  getSession() async {
    session = await loadSession();
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    getSession();
  }
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
                const Center(
                  child: Text('PAGA TU TURNO', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                ),
                const SizedBox(height: 15,),
                const Text('RAZON SOCIAL XXXXXXX', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 15,),
                const Text('BANCO BANAMEX', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 15,),
                const Text('CUENTA XXXXXXX', style: TextStyle(color: Colors.yellow, fontSize: 20)),
                const SizedBox(height: 15,),
                Center(
                  // ignore: prefer_interpolation_to_compose_strings
                  child: Text('${'Concepto ('+session['info'][8]})', style: const TextStyle(color: Colors.yellow, fontSize: 20)),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: TextButton(
                    onPressed: () async{
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        path = image!.path;
                      });
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                    child: const Text('Subir comprobante', style: TextStyle(color: Colors.black, fontSize: 20))
                  ),
                ),
                const SizedBox(height: 30,),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      if(path == ''){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Toma una foto del comorobante')));
                        return;
                      }
                      List<int> bytes = File(path).readAsBytesSync();
                        try{
                          var data = {
                            'img':  base64.encode(bytes)
                          };
                          final response = await http.Client().patch(
                            Uri.http('10.0.2.2', '/dinerus/public/api/user/paid', {'api_token': session['apiToken']}),
                            body: jsonEncode(data),
                            headers: {
                              'Content-type': 'application/json',
                              'Accept': 'application/json',
                              'Charset': 'utf-8'
                            },
                          );
                          if(response.statusCode == 200){
                            // ignore: use_build_context_synchronously
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfirmationPage()));
                          }
                        } on SocketException{
                          // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error de servidor')));
                        }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                    child: const Text('SIGUIENTE', style: TextStyle(color: Colors.black, fontSize: 22))
                  ),
                ),
              ],
            )
          ]
          ),
      ),
    );
  }
}