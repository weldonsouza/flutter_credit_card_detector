# flutter_credit_card_detector

[![pub package](https://img.shields.io/pub/v/flutter_credit_card_detector?color=blue)](https://pub.dev/packages/flutter_credit_card_detector)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J6RRWN8NLRB84&source=url)

Um pacote Flutter que permite você implementar facilmente a interface do usuário do cartão de crédito com a detecção do cartão.

## Preview
![O aplicativo de exemplo em execução no Android](https://github.com/weldonsouza/flutter_credit_card_detector/blob/master/preview/preview.gif)

## Screenshot
![screenshot4](https://github.com/weldonsouza/flutter_credit_card_detector/blob/master/screenshot/screenshot4.png)
![screenshot5](https://github.com/weldonsouza/flutter_credit_card_detector/blob/master/screenshot/screenshot5.png)

Aplicativo disponível na [`Play Store`](https://play.google.com/store/apps/details?id=com.neduki.creditcarddetector)

## Uso
1. Adicione dependência a `pubspec.yaml`

```dart
dependencies:
    flutter_credit_card_detector: 2.1.0
```

2. Importar o pacote
```dart
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';
```

3. Adicionando CreditCardWidget
- *Com parâmetros requeridos*
```dart
...
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          Provider<Controller>(
            create: (_) => Controller(),
            dispose: (_, controler) => controler.dispose(),
          )
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Demo'),
              backgroundColor: Colors.orange[300],
            ),
            body: CreditCardWidget(onTap: _onTap)),
      );
    }
...
      _onTap() async {
        print('Numero do cartão: $creditCardNumber'); // Numero do cartão digitado
        print('Nome no cartão: $creditCardName'); // Nome no cartão digitado
        print('Valido até: $creditCardExpData'); // Validade do cartão
        print('CVV: $creditCardCVV'); // Código de segurança
        print('Bandeira: $creditCardBand'); // Bandeira do cartão
        print('CPF: $creditCardCPF'); // CPF do Titular
      }
...
```
- *Com parâmetros opcionais*
```dart
...
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
        textNameMin: 'O nome de conter pelo menos 6 caracteres', // Mensagem de erro no textField - campo nome
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
        viewLayout: false, // Vertical = false, Horizontal = true
        cpfVisibility: true, // Campo do CPF visível = true e false para ocultar o campo
        listBand: ['visa', 'mastercard'], // Definir quais cartões estarão disponíveis
        onTap: onTap, // Função
    ),
...
```
# Recursos
* Cartões suportados:
    * Visa
    * Mastercard
    * American Express
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
