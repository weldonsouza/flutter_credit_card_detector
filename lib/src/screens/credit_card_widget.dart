import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

import '../../flutter_credit_card_detector.dart';

class CreditCardWidget extends StatefulWidget {
  final String labelTextNum;
  final String labelTextName;
  final String labelTextExpData;
  final String labelTextCVV;
  final String labelTextCPF;
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
  final double textSizeNumber; // body_widget
  final double textSizeName; // body_widget
  final double textSizeMonth; // body_widget
  final double textSizeCVC; // body_widget
  final List<String> listBand;
  final bool viewLayout;
  final bool cpfVisibility;
  final Function() onTap;

  const CreditCardWidget(
      {Key key,
      this.labelTextNum = 'Numero do cartão',
      this.labelTextName = 'Nome no cartão',
      this.labelTextExpData = 'MM/YY',
      this.labelTextCVV = 'CVV/CVC',
      this.labelTextCPF = 'CPF do Titular',
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
      this.textSizeNumber = 0.06,
      this.textSizeName = 0.045,
      this.textSizeMonth = 0.03,
      this.textSizeCVC = 0.03,
      this.listBand = const [
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
      ],
      this.viewLayout = false,
      this.cpfVisibility = true,
      this.onTap})
      : super(key: key);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  FocusNode _numFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();
  FocusNode _expDateFocus = FocusNode();
  FocusNode _cvvFocus = FocusNode();
  FocusNode _cpfFocus = FocusNode();

  final _ccNum = MaskedTextController(mask: "0000 0000 0000 0000");
  final _nome = TextEditingController();
  final _expData = MaskedTextController(mask: "00/00");
  final _cvv = TextEditingController();
  final _cpf = TextEditingController();

  final textFieldNum = GlobalKey();
  final textFieldNam = GlobalKey();
  final textFieldExpD = GlobalKey();
  final textFieldCvv = GlobalKey();
  final textFieldCpf = GlobalKey();

  @override
  void initState() {
    super.initState();
    creditCardNumber = '';
    creditCardName = '';
    creditCardExpData = '';
    creditCardCVV = '';
    creditCardBand = '';
    creditCardCPF = '';

    validateCpfVisibility = widget.cpfVisibility;

    textRequired = widget.textRequired;
    textSelectBand = widget.textSelectBand;
    textNameMin = widget.textNameMin;
    textIntroNameValid = widget.textIntroNameValid;
    textCardExpired = widget.textCardExpired;
    textInvalidateMonth = widget.textInvalidateMonth;

    listBand = widget.listBand;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);

    controller.creditCard.number = _ccNum.text == '' ? '' : _ccNum.text;
    controller.creditCard.name = _nome.text == '' ? '' : _nome.text;
    controller.creditCard.expData = _expData.text == '' ? '' : _expData.text;
    controller.creditCard.cvv = _cvv.text == '' ? '' : _cvv.text;
    controller.creditCard.cpf = _cpf.text == '' ? '' : _cpf.text;

    _textFormField(
        {width,
        keyText,
        controllerTextField,
        keyboardType,
        textInputAction,
        maxLength,
        focusNode,
        onChanged,
        textCapitalization,
        nextFocusNode,
        labelText,
        nextTexFieldView,
        String Function() errorText}) {
      return Container(
          width: width,
          child: TextFormField(
            key: keyText,
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
                creditCardCPF = controller.creditCard.cpf;
                creditCardBand = controller.validateIconBand();

                widget.onTap();
              } else {
                return null;
              }
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(nextFocusNode);
              nextTexFieldView == null
                  ? null
                  : nextTexFieldView.currentContext
                      .findRenderObject()
                      .showOnScreen(duration: Duration(seconds: 0));
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

    Widget _inputSectionRow() {
      return Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Observer(
                  name: 'Numero do cartão',
                  builder: (_) {
                    return _textFormField(
                        keyText: textFieldNum,
                        width: mediaQuery(context, 0.7),
                        controllerTextField: _ccNum,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 19,
                        focusNode: _numFocus,
                        onChanged: controller.creditCard.changeNumero,
                        textCapitalization: TextCapitalization.none,
                        nextFocusNode: _nameFocus,
                        labelText: widget.labelTextNum,
                        nextTexFieldView: textFieldNam,
                        errorText: controller.validateNumero);
                  }),
              SizedBox(width: 10),
              Observer(
                  name: 'Nome no cartão',
                  builder: (_) {
                    return _textFormField(
                        keyText: textFieldNam,
                        width: mediaQuery(context, 0.8),
                        controllerTextField: _nome,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        maxLength: 25,
                        focusNode: _nameFocus,
                        onChanged: controller.creditCard.changeName,
                        textCapitalization: TextCapitalization.characters,
                        nextFocusNode: _expDateFocus,
                        labelText: widget.labelTextName,
                        nextTexFieldView: textFieldExpD,
                        errorText: controller.validateName);
                  }),
              SizedBox(width: 10),
              Observer(
                  name: 'MM/YY',
                  builder: (_) {
                    return _textFormField(
                        keyText: textFieldExpD,
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
                        nextTexFieldView: textFieldCvv,
                        errorText: controller.validateExpData);
                  }),
              SizedBox(width: 10),
              Observer(
                  name: 'CVV/CVC',
                  builder: (_) {
                    var ccType = detectCCType(controller.creditCard.number);
                    return _textFormField(
                        keyText: textFieldCvv,
                        width: mediaQuery(context, 0.45),
                        controllerTextField: _cvv,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: ccType == CreditCardType.amex ||
                                ccType == CreditCardType.discover
                            ? 4
                            : 3,
                        focusNode: _cvvFocus,
                        onChanged: controller.creditCard.changeCVV,
                        textCapitalization: TextCapitalization.none,
                        nextFocusNode: _cpfFocus,
                        labelText: widget.labelTextCVV,
                        nextTexFieldView: textFieldCpf,
                        errorText: controller.validateCVV);
                  }),
              widget.cpfVisibility == false ? Container() : SizedBox(width: 10),
              widget.cpfVisibility == false
                  ? Container()
                  : Observer(
                      name: 'CPF',
                      builder: (_) {
                        return _textFormField(
                            keyText: textFieldCpf,
                            width: mediaQuery(context, 0.7),
                            controllerTextField: _cpf,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            maxLength: 11,
                            focusNode: _cpfFocus,
                            onChanged: controller.creditCard.changeCpf,
                            textCapitalization: TextCapitalization.characters,
                            labelText: widget.labelTextCPF,
                            errorText: controller.validateCPF);
                      }),
            ],
          ),
        ),
      );
    }

    Widget _inputSectionColunm() {
      return Column(
        children: <Widget>[
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
                        textInputAction: TextInputAction.next,
                        maxLength: ccType == CreditCardType.amex ||
                                ccType == CreditCardType.discover
                            ? 4
                            : 3,
                        focusNode: _cvvFocus,
                        onChanged: controller.creditCard.changeCVV,
                        textCapitalization: TextCapitalization.none,
                        nextFocusNode: _cpfFocus,
                        labelText: widget.labelTextCVV,
                        nextTexFieldView: textFieldCpf,
                        errorText: controller.validateCVV);
                  }),
            ],
          ),
          widget.cpfVisibility == false ? Container() : SizedBox(height: 8),
          widget.cpfVisibility == false
              ? Container()
              : Observer(
                  name: 'CPF',
                  builder: (_) {
                    return _textFormField(
                        controllerTextField: _cpf,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 11,
                        focusNode: _cpfFocus,
                        onChanged: controller.creditCard.changeCpf,
                        textCapitalization: TextCapitalization.characters,
                        labelText: widget.labelTextCPF,
                        errorText: controller.validateCPF);
                  }),
        ],
      );
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
            colorCreditBlack: widget.colorCreditBlack,
            textSizeNumber: widget.textSizeNumber,
            textSizeName: widget.textSizeName,
            textSizeMonth: widget.textSizeMonth,
            textSizeCVC: widget.textSizeCVC,
            listBand: widget.listBand,
          ),
          SizedBox(height: 10),
          widget.viewLayout == true
              ? _inputSectionRow()
              : _inputSectionColunm(),
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
                            creditCardCPF = controller.creditCard.cpf;
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
