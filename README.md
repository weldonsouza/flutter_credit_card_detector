# flutter_credit_card_detector

Um pacote Flutter que permite você implementar facilmente a interface do usuário do cartão de crédito com a detecção do cartão.

## Preview
![O aplicativo de exemplo em execução no Android](https://github.com/weldonsouza/flutter_credit_card_detector/blob/master/preview/preview.gif)

## Uso
1. Adicione dependência a `pubspec.yaml`

```dart
dependencies:
    flutter_credit_card_detector: 0.1.5
```

2. Importar o pacote
```dart
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';
```

3. Adicionando CreditCardDetector
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
            body: CreditCardDetector(onTap: _onTap)),
      );
    }
...
      _onTap() async {
        print('Numero do cartão: $creditCardNumber'); // Numero do cartão digitado
        print('Nome no cartão: $creditCardName'); // Nome no cartão digitado
        print('Valido até: $creditCardExpData'); // Validade do cartão
        print('CVV: $creditCardCVV'); // Código de segurança
        print('Bandeira: $creditCardBand'); // Bandeira do cartão
      }
...
```
- *Com parâmetros opcionais*
```dart
...
    CreditCardDetector(
        labelTextNum: 'Numero do cartão', // Texto exibido no textField
        labelTextName: 'Nome no cartão', // Texto exibido no textField
        labelTextExpData: 'MM/YY', // Texto exibido no textField
        labelTextCVV: 'CVV/CVC', // Texto exibido no textField
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