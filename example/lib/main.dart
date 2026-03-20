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
      title: 'Credit Card Detector Example',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const List<String> _listBand = [
    'visa',
    'mastercard',
    'amex',
    'maestro',
    'unionpay',
    'troy',
    'dankort',
    'uatp',
    'elo',
    'dinersclub',
    'discover',
    'jcb',
    'aura',
    'hiper',
    'hipercard',
    'rupay',
  ];

  void _onTap() {
    debugPrint('Numero do cartão: $creditCardNumber');
    debugPrint('Nome no cartão: $creditCardName');
    debugPrint('Valido até: $creditCardExpData');
    debugPrint('CVV: $creditCardCVV');
    debugPrint('Bandeira: $creditCardBand');
    debugPrint('CPF: $creditCardCPF');
  }

  Widget _buildExample({
    required CreditCardStylePreset preset,
    String? fontFamily,
    double borderRadius = 16,
    double elevation = 5,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: CreditCardWidget(
          key: ValueKey<CreditCardStylePreset>(preset),
          listBand: _listBand,
          cardStylePreset: preset,
          fontFamily: fontFamily,
          cardBorderRadius: borderRadius,
          cardElevation: elevation,
          onTap: _onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Credit Card Detector'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Modern'),
              Tab(text: 'Glass'),
              Tab(text: 'Midnight'),
              Tab(text: 'Custom'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExample(
              preset: CreditCardStylePreset.modern,
              fontFamily: 'Roboto',
              borderRadius: 18,
              elevation: 7,
            ),
            _buildExample(
              preset: CreditCardStylePreset.glass,
              borderRadius: 20,
              elevation: 2,
            ),
            _buildExample(
              preset: CreditCardStylePreset.midnight,
              borderRadius: 16,
              elevation: 6,
            ),
            _buildExample(
              preset: CreditCardStylePreset.custom,
              borderRadius: 12,
              elevation: 3,
            ),
          ],
        ),
      ),
    );
  }
}
