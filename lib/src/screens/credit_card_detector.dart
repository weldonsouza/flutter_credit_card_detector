import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

class CreditCardDetector extends StatefulWidget {
  final String labelTextNum;
  final String labelTextName;
  final String labelTextExpData;
  final String labelTextCVV;
  final String labelTextButton;
  final String titleCreditCard; // body_widget
  final String labelTextValidate; // body_widget
  final String textRequired; // Controller
  final String textSelectBand; // Controller
  final String textNameMin; // Controller
  final String textIntroNameValid; // Controller
  final String textCardExpired; // Controller
  final String textInvalidateMonth; // Controller
  final Color colorButton;
  final Color colorTextButton;
  final Color colorTextField;
  final Color colorCardSelect; // body_widget
  final Color colorCreditWhite; // body_widget
  final Color colorCreditBlack; // body_widget
  final Function() onTap;

  const CreditCardDetector(
      {Key key,
      this.labelTextNum = 'Numero do cartão',
      this.labelTextName = 'Nome no cartão',
      this.labelTextExpData = 'MM/YY',
      this.labelTextCVV = 'CVV/CVC',
      this.labelTextButton = 'Efetuar pagamento',
      this.titleCreditCard = 'Cartão de Crédito',
      this.labelTextValidate = 'Valido Até',
      this.textRequired = 'Campo é obrigatorio',
      this.textSelectBand = 'Selecione a bandeira',
      this.textNameMin = 'O nome de conter pelo menos 6 caracteres',
      this.textIntroNameValid = 'Insira um nome válido',
      this.textCardExpired = 'Cartão vencido',
      this.textInvalidateMonth = 'Mês incorreto.',
      this.colorButton = const Color(0xFFfec177),
      this.colorTextButton = Colors.white,
      this.colorTextField = Colors.grey,
      this.colorCardSelect = const Color(0xFFfec177),
      this.colorCreditWhite = const Color(0xff535252),
      this.colorCreditBlack = const Color(0xff211e1e),
      this.onTap})
      : super(key: key);

  @override
  _CreditCardDetectorState createState() => _CreditCardDetectorState();
}

class _CreditCardDetectorState extends State<CreditCardDetector> {
  FocusNode _numFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _expDateFocus = FocusNode();
  FocusNode _cvvFocus = FocusNode();

  final _ccNum = MaskedTextController(mask: "0000 0000 0000 0000");
  final _nome = TextEditingController();
  final _expData = MaskedTextController(mask: "00/00");
  final _cvv = TextEditingController();

  @override
  void initState() {
    super.initState();
    creditCardNumber = '';
    creditCardName = '';
    creditCardExpData = '';
    creditCardCVV = '';
    creditCardBand = '';

    textRequired = widget.textRequired;
    textSelectBand = widget.textSelectBand;
    textNameMin = widget.textNameMin;
    textIntroNameValid = widget.textIntroNameValid;
    textCardExpired = widget.textCardExpired;
    textInvalidateMonth = widget.textInvalidateMonth;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);

    controller.creditCard.number = _ccNum.text == '' ? '' : _ccNum.text;
    controller.creditCard.name = _nome.text == '' ? '' : _nome.text;
    controller.creditCard.expData = _expData.text == '' ? '' : _expData.text;
    controller.creditCard.cvv = _cvv.text == '' ? '' : _cvv.text;

    _textFormField(
        {width,
        controllerTextField,
        keyboardType,
        textInputAction,
        maxLength,
        focusNode,
        onChanged,
        textCapitalization,
        nextFocusNode,
        labelText,
        String Function() errorText}) {
      return Container(
          width: width,
          child: TextFormField(
            controller: controllerTextField,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLength: maxLength,
            focusNode: focusNode,
            onChanged: onChanged,
            textCapitalization: textCapitalization,
            inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'[.,]'))],
            onFieldSubmitted: (v) {
              if (controller.isValid) {
                creditCardNumber =
                    controller.creditCard.number.replaceAll(' ', '');
                creditCardName = controller.creditCard.name;
                creditCardExpData = controller.creditCard.expData;
                creditCardCVV = controller.creditCard.cvv;
                creditCardBand = controller.validateIconBand();

                widget.onTap();
              } else {
                return null;
              }
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(nextFocusNode);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorButton),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.colorButton),
              ),
              labelText: labelText,
              labelStyle: TextStyle(color: widget.colorTextField),
              errorText: errorText == null ? null : errorText(),
            ),
          ));
    }

    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: mediaQuery(context, 0.025)),
      child: Column(
        children: <Widget>[
          BodyWidget(
              titleCreditCard: widget.titleCreditCard,
              labelTextValidate: widget.labelTextValidate,
              colorCardSelect: widget.colorCardSelect,
              colorCreditWhite: widget.colorCreditWhite,
              colorCreditBlack: widget.colorCreditBlack),
          SizedBox(height: 10),
          Observer(
              name: 'Numero do cartão',
              builder: (_) {
                return _textFormField(
                    controllerTextField: _ccNum,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 19,
                    focusNode: _numFocus,
                    onChanged: controller.creditCard.changeNumero,
                    textCapitalization: TextCapitalization.none,
                    nextFocusNode: _nameFocus,
                    labelText: widget.labelTextNum,
                    errorText: controller.validateNumero);
              }),
          SizedBox(height: 8),
          Observer(
              name: 'Nome no cartão',
              builder: (_) {
                return _textFormField(
                    controllerTextField: _nome,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLength: 25,
                    focusNode: _nameFocus,
                    onChanged: controller.creditCard.changeName,
                    textCapitalization: TextCapitalization.characters,
                    nextFocusNode: _expDateFocus,
                    labelText: widget.labelTextName,
                    errorText: controller.validateName);
              }),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Observer(
                  name: 'MM/YY',
                  builder: (_) {
                    return _textFormField(
                        width: mediaQuery(context, 0.45),
                        controllerTextField: _expData,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 5,
                        focusNode: _expDateFocus,
                        onChanged: controller.creditCard.changeExpData,
                        textCapitalization: TextCapitalization.none,
                        nextFocusNode: _cvvFocus,
                        labelText: widget.labelTextExpData,
                        errorText: controller.validateExpData);
                  }),
              Observer(
                  name: 'CVV/CVC',
                  builder: (_) {
                    var ccType = detectCCType(controller.creditCard.number);

                    return _textFormField(
                        width: mediaQuery(context, 0.45),
                        controllerTextField: _cvv,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: ccType == CreditCardType.amex ||
                                ccType == CreditCardType.discover
                            ? 4
                            : 3,
                        focusNode: _cvvFocus,
                        onChanged: controller.creditCard.changeCVV,
                        textCapitalization: TextCapitalization.none,
                        labelText: widget.labelTextCVV,
                        errorText: controller.validateCVV);
                  }),
            ],
          ),
          SizedBox(height: 8),
          Observer(
              name: 'RaisedButton efetuar pagamento',
              builder: (_) {
                return RaisedButton(
                    color: widget.colorButton,
                    onPressed: controller.isValid
                        ? () {
                            creditCardNumber = controller.creditCard.number
                                .replaceAll(' ', '');
                            creditCardName = controller.creditCard.name;
                            creditCardExpData = controller.creditCard.expData;
                            creditCardCVV = controller.creditCard.cvv;
                            creditCardBand = controller.validateIconBand();

                            widget.onTap();
                          }
                        : null,
                    child: Text(
                      widget.labelTextButton,
                      style: TextStyle(color: widget.colorTextButton),
                    ));
              }),
        ],
      ),
    ));
  }
}
