import 'package:flutter/material.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControllerBase()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Demo'),
            backgroundColor: Colors.orange[300],
          ),
          body: CreditCardWidget(listBand: listBand, onTap: _onTap)),
      debugShowCheckedModeBanner: false,
    );
  }

  // Bandeiras disponíveis
  List<String> listBand = ['visa', 'mastercard', 'amex', 'elo', 'dinersclub', 'discover', 'jcb', 'aura', 'hiper', 'hipercard', 'rupay'];

  _onTap() async {
    print('Numero do cartão: $creditCardNumber'); // Numero do cartão digitado
    print('Nome no cartão: $creditCardName'); // Nome no cartão digitado
    print('Valido até: $creditCardExpData'); // Validade do cartão
    print('CVV: $creditCardCVV'); // Código de segurança
    print('Bandeira: $creditCardBand'); // Bandeira do cartão
    print('CPF: $creditCardCPF'); // CPF do Titular
  }
}
