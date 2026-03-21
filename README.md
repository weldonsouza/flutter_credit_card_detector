# flutter_credit_card_detector

[![pub package](https://img.shields.io/pub/v/flutter_credit_card_detector?color=blue)](https://pub.dev/packages/flutter_credit_card_detector)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J6RRWN8NLRB84&source=url)

Um pacote Flutter que permite você implementar facilmente a interface do usuário do cartão de crédito com a detecção do cartão.

## Preview
![O aplicativo de exemplo em execução no Android](https://raw.githubusercontent.com/weldonsouza/flutter_credit_card_detector/master/preview/preview.gif)

## Screenshot
![screenshot4](https://raw.githubusercontent.com/weldonsouza/flutter_credit_card_detector/master/screenshot/screenshot4.png)
![screenshot5](https://raw.githubusercontent.com/weldonsouza/flutter_credit_card_detector/master/screenshot/screenshot5.png)

Aplicativo disponível na [`Play Store`](https://play.google.com/store/apps/details?id=com.neduki.creditcarddetector)

## Uso
1. Adicione dependência a `pubspec.yaml`

```dart
dependencies:
    flutter_credit_card_detector: ^3.0.3
```

2. Importar o pacote
```dart
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';
```

3. Adicionando `CreditCardWidget`

- *Com parâmetros requeridos*
```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControllerBase()),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: CreditCardWidget(onTap: _onTap),
        ),
      ),
    ),
  );
}

void _onTap() {
  debugPrint('Numero do cartão: $creditCardNumber');
  debugPrint('Nome no cartão: $creditCardName');
  debugPrint('Valido até: $creditCardExpData');
  debugPrint('CVV: $creditCardCVV');
  debugPrint('Bandeira: $creditCardBand');
  debugPrint('CPF: $creditCardCPF');
}
```
- *Com parâmetros opcionais*
```dart
CreditCardWidget(
        labelTextNum: 'Numero do cartão', // Texto exibido no textField
        labelTextName: 'Nome no cartão', // Texto exibido no textField
        labelTextExpData: 'MM/YY', // Texto exibido no textField
        labelTextCVV: 'CVV/CVC', // Texto exibido no textField
        labelTextCPF: 'CPF do Titular', // Texto exibido no textField
        labelTextButton: 'Efetuar pagamento', // Texto do button
        titleCreditCard: 'Cartão de Crédito', // Título do cartão
        labelTextValidate: 'Valido Até', // Texto de validade do cartão
        textRequired: 'Campo é obrigatorio', // Mensagem de erro no textField - campos vazios
        textSelectBand: 'Selecione a bandeira', // Mensagem de erro no textField - quando a bandeira não é identificada
        textNameMin: 'O nome deve conter pelo menos 3 caracteres', // Mensagem de erro no textField - campo nome
        textIntroNameValid: 'Insira um nome válido', // Mensagem de erro no textField - campo nome
        textCardExpired: 'Cartão vencido', // Mensagem de erro no textField - campo validade do cartão
        textInvalidateMonth: 'Mês incorreto.', // Mensagem de erro no textField - campo validade do cartão
        colorButton: const Color(0xFFfec177), // Cor do button
        colorTextButton: Colors.white, // Cor do texto no button
        colorTextField: Colors.grey, // Cor do texto no textField
        colorCardSelect: const Color(0xFFfec177), // Cor do card selecionado
        colorCreditWhite: const Color(0xff535252), // Cor do cartão
        colorCreditBlack: const Color(0xff211e1e), // Cor do cartão
        textSizeNumber: 0.06, // Tamanho do número apresentado no cartão
        textSizeName: 0.04, // Tamanho do nome apresentado no cartão
        textSizeMonth: 0.03, // Tamanho do texto apresentado no cartão
        textSizeCVC: 0.03, // Tamanho do texto apresentado no cartão
        cardStylePreset: CreditCardStylePreset.modern, // custom, modern, glass, midnight
        fontFamily: 'Roboto', // Fonte do cartão
        cardBorderRadius: 18, // Borda do cartão
        cardElevation: 7, // Elevação do cartão
        cardMargin: const EdgeInsets.symmetric(horizontal: 8),
        cardContentPadding: const EdgeInsets.all(18),
        titleTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        numberTextStyle: const TextStyle(fontSize: 36, letterSpacing: 1.6),
        nameTextStyle: const TextStyle(fontSize: 18),
        detailLabelTextStyle: const TextStyle(fontSize: 12),
        detailValueTextStyle: const TextStyle(fontSize: 16),
        viewLayout: false, // Vertical = false, Horizontal = true
        cpfVisibility: true, // Campo do CPF visível = true e false para ocultar o campo
        listBand: ['visa', 'mastercard'], // Definir quais cartões estarão disponíveis
        onTap: onTap, // Função
),
```

### Personalização dos campos de texto (`TextFormField`)

O `CreditCardWidget` repassa para **todos** os campos (número, nome, validade, CVV, CPF) os parâmetros opcionais:

- `inputDecoration` — `InputDecoration` completo (o erro de validação continua sendo mesclado).
- `inputContentPadding` — padding interno (quando não usa `inputDecoration`).
- `inputBorder`, `inputEnabledBorder`, `inputFocusedBorder`, `inputErrorBorder`, `inputFocusedErrorBorder` — bordas no modo padrão (sem `inputDecoration`).

```dart
CreditCardWidget(
  onTap: onTap,
  inputContentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  inputBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.orange, width: 1.5),
  ),
  inputFocusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
  ),
);
```

Para controle fino por campo, use o widget `CreditCardInputField` diretamente (também exportado por `flutter_credit_card_detector.dart`).

# Recursos
* Cartões suportados:
    * Visa
    * Mastercard
    * American Express
    * Maestro
    * UnionPay
    * Troy
    * Dankort
    * UATP
    * Aura
    * DinersClub
    * Discover
    * Elo
    * Hiper
    * Hipercard
    * JCB
    * Rupay

Para mais detalhes sobre o uso, confira o aplicativo example fornecido.

# Licença
O flutter_credit_card_detector é liberado sob a licença MIT. Consulte [LICENÇA](./LICENSE) para obter detalhes.
