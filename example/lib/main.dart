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
    required Object tabKey,
    required CreditCardStylePreset preset,
    String? fontFamily,
    double borderRadius = 16,
    double elevation = 5,
    bool showCardScanDemo = false,
    bool viewLayout = false,
    bool customScanButton = false,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: CreditCardWidget(
          key: ValueKey<Object>(tabKey),
          listBand: _listBand,
          cardStylePreset: preset,
          fontFamily: fontFamily,
          cardBorderRadius: borderRadius,
          cardElevation: elevation,
          viewLayout: viewLayout,
          onTap: _onTap,
          showCardScanAction: showCardScanDemo,
          onCardScan: showCardScanDemo
              ? () async {
                  await Future<void>.delayed(const Duration(milliseconds: 800));
                  return const CardScanResult(
                    cardNumber: '4111111111111111',
                    holderName: 'DEMO OCR',
                    expiryMmYy: '12/30',
                  );
                }
              : null,
          cardScanButtonBuilder: showCardScanDemo && customScanButton
              ? (context, data) {
                  final icon = data.loading
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: data.iconColor,
                          ),
                        )
                      : Icon(data.icon, size: 22, color: data.iconColor);
                  return IconButton.filledTonal(
                    onPressed: data.onPressed,
                    tooltip: data.tooltip,
                    style: IconButton.styleFrom(
                      backgroundColor: data.iconColor.withValues(alpha: 0.22),
                    ),
                    icon: icon,
                  );
                }
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Credit Card Detector'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: 'Modern'),
                  Tab(text: 'Glass'),
                  Tab(text: 'Midnight'),
                  Tab(text: 'Custom'),
                  Tab(text: 'Horizontal'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildExample(
              tabKey: 'modern',
              preset: CreditCardStylePreset.modern,
              fontFamily: 'Roboto',
              borderRadius: 18,
              elevation: 7,
            ),
            _buildExample(
              tabKey: 'glass',
              preset: CreditCardStylePreset.glass,
              borderRadius: 20,
              elevation: 2,
            ),
            _buildExample(
              tabKey: 'midnight',
              preset: CreditCardStylePreset.midnight,
              borderRadius: 16,
              elevation: 6,
            ),
            _buildExample(
              tabKey: 'custom_scan',
              preset: CreditCardStylePreset.custom,
              borderRadius: 12,
              elevation: 3,
              showCardScanDemo: true,
            ),
            _buildExample(
              tabKey: 'horizontal_modern',
              preset: CreditCardStylePreset.modern,
              fontFamily: 'Roboto',
              borderRadius: 18,
              elevation: 7,
              viewLayout: true,
              showCardScanDemo: true,
              customScanButton: true,
            ),
          ],
        ),
      ),
    );
  }
}
