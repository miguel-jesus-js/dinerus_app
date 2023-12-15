import 'package:dinerus_app/TermsAndConditions.dart';
import 'package:dinerus_app/models/Session.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
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
                const Center(
                  child: Text('CONFIRMA TU INFORMACIÓN', style: TextStyle(color: Colors.yellow, fontSize: 22)),
                ),
                const SizedBox(height: 50,),
                const MyRows(),
                const SizedBox(height: 50,),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditions()));
                  },
                  child: const Text('FINALIZADO', style: TextStyle(color: Colors.yellow, fontSize: 30))
                ),
              ],
            )
          ]
          ),
      ),
    );
  }
}

class MyRows extends StatefulWidget {
  const MyRows({super.key});

  @override
  State<MyRows> createState() => _MyRowsState();
}

class _MyRowsState extends State<MyRows> {
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
    return Column(
      children: [
        MyRow(clave: 'NOMBRE:', valor: session['info'][1]),
        MyRow(clave: 'CURP:', valor: session['info'][2]),
        MyRow(clave: 'RFC:', valor: session['info'][3]),
        MyRow(clave: 'BANCO A RECIBIR TU DINERO:', valor: session['info'][7]),
        MyRow(clave: 'CLABE INTERBANCARIA 18 DIGITOS:', valor: session['info'][6]),
        MyRow(clave: 'TU NÚMERO DE TURNO ES:', valor: session['info'][8]),
      ],
    );
  }
}

class MyRow extends StatelessWidget {
  final String clave;
  final String valor;

  // ignore: prefer_const_constructors_in_immutables
  MyRow({super.key, required this.clave, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(clave, style: const TextStyle(color: Colors.yellow),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(valor, style: const TextStyle(color: Colors.yellow),
          ),
        ),
      ],
    );
  }
}