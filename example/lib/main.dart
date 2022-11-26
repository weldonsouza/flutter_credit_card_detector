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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
          backgroundColor: Colors.orange[300],
        ),
        body: CreditCardWidget(listBand: listBand, onTap: _onTap),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  // Bandeiras disponíveis
  List<String> listBand = [
    'visa',
    'mastercard',
    'amex',
    'elo',
    'dinersclub',
    'discover',
    'jcb',
    'aura',
    'hiper',
    'hipercard',
    'rupay'
  ];

  _onTap() async {
    print('Numero do cartão: $creditCardNumber'); // Numero do cartão digitado
    print('Nome no cartão: $creditCardName'); // Nome no cartão digitado
    print('Valido até: $creditCardExpData'); // Validade do cartão
    print('CVV: $creditCardCVV'); // Código de segurança
    print('Bandeira: $creditCardBand'); // Bandeira do cartão
    print('CPF: $creditCardCPF'); // CPF do Titular
  }
}
