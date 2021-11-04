import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MaterialApp(
    title: 'app',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String _infoTexto = "Digite seus dados!";
  void _resetFields() {
    textHeight.text = "";
    textWeight.text = "";
    setState(() {
      _infoTexto = "Digite seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _Calcular() {
    setState(() {
      double weight = double.parse(textWeight.text);
      double height = double.parse(textHeight.text) / 100;
      double imc = (weight / (height * height));
      print(imc);
      if (imc <= 18.6) {
        _infoTexto = "Abaixo do peso! ${imc.toStringAsPrecision(4)}";
      } else if (imc > 18.6 && imc <= 24.9) {
        _infoTexto = "Tá bom! ${imc.toStringAsPrecision(4)}";
      } else if (imc > 24.9) {
        _infoTexto = "Hora de emagrecer! ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  TextEditingController textWeight = TextEditingController();
  TextEditingController textHeight = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                _resetFields();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(Icons.person_outline, size: 120, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso(kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    controller: textWeight,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura(cm)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      controller: textHeight,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua altura!";
                        }
                      }),
                  Container(
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _Calcular();
                          }
                        },
                        child: Text("Calcular", style: TextStyle(fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        )),
                  ),
                  Text(_infoTexto,
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center)
                ],
              ))),
    );
  }
}
