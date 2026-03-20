import 'package:flutter/material.dart';
import 'package:flutter_credit_card_detector/flutter_credit_card_detector.dart';

import '../utils/mask_text_input_formatter.dart';
import 'widgets/credit_card_form_section.dart';
import 'widgets/credit_card_submit_button.dart';

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
  final String? fontFamily; // body_widget
  final TextStyle? titleTextStyle; // body_widget
  final TextStyle? numberTextStyle; // body_widget
  final TextStyle? nameTextStyle; // body_widget
  final TextStyle? detailLabelTextStyle; // body_widget
  final TextStyle? detailValueTextStyle; // body_widget
  final double cardBorderRadius; // body_widget
  final double cardElevation; // body_widget
  final EdgeInsetsGeometry cardMargin; // body_widget
  final EdgeInsetsGeometry cardContentPadding; // body_widget
  final CreditCardStylePreset cardStylePreset; // body_widget
  final List<String> listBand;
  final bool viewLayout;
  final bool cpfVisibility;
  final VoidCallback onTap;

  const CreditCardWidget({
    super.key,
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
    this.textNameMin = 'O nome de conter pelo menos 3 caracteres',
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
    this.fontFamily,
    this.titleTextStyle,
    this.numberTextStyle,
    this.nameTextStyle,
    this.detailLabelTextStyle,
    this.detailValueTextStyle,
    this.cardBorderRadius = 12,
    this.cardElevation = 3,
    this.cardMargin = const EdgeInsets.symmetric(horizontal: 5),
    this.cardContentPadding = const EdgeInsets.all(16),
    this.cardStylePreset = CreditCardStylePreset.custom,
    this.listBand = const [
      'visa',
      'mastercard',
      'amex',
      'maestro',
      'unionpay',
      'mir',
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
      'rupay'
    ],
    this.viewLayout = false,
    this.cpfVisibility = true,
    required this.onTap,
  });

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final FocusNode _numFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _expDateFocus = FocusNode();
  final FocusNode _cvvFocus = FocusNode();
  final FocusNode _cpfFocus = FocusNode();

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
  void dispose() {
    _numFocus.dispose();
    _nameFocus.dispose();
    _expDateFocus.dispose();
    _cvvFocus.dispose();
    _cpfFocus.dispose();
    _ccNum.dispose();
    _nome.dispose();
    _expData.dispose();
    _cvv.dispose();
    _cpf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerBase>(context);

    controller.number = _ccNum.text == '' ? '' : _ccNum.text;
    controller.name = _nome.text == '' ? '' : _nome.text;
    controller.expData = _expData.text == '' ? '' : _expData.text;
    controller.cvv = _cvv.text == '' ? '' : _cvv.text;
    controller.cpf = _cpf.text == '' ? '' : _cpf.text;

    void submitIfValid() {
      if (!controller.isValid) return;
      creditCardNumber = controller.number.replaceAll(' ', '');
      creditCardName = controller.name;
      creditCardExpData = controller.expData;
      creditCardCVV = controller.cvv;
      creditCardCPF = controller.cpf;
      creditCardBand = controller.typeBand;
      widget.onTap();
    }

    final ccType = detectCCType(controller.number);

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
              fontFamily: widget.fontFamily,
              titleTextStyle: widget.titleTextStyle,
              numberTextStyle: widget.numberTextStyle,
              nameTextStyle: widget.nameTextStyle,
              detailLabelTextStyle: widget.detailLabelTextStyle,
              detailValueTextStyle: widget.detailValueTextStyle,
              cardBorderRadius: widget.cardBorderRadius,
              cardElevation: widget.cardElevation,
              cardMargin: widget.cardMargin,
              cardContentPadding: widget.cardContentPadding,
              cardStylePreset: widget.cardStylePreset,
              listBand: widget.listBand,
            ),
            SizedBox(height: 10),
            CreditCardFormSection(
              layoutMode: widget.viewLayout
                  ? CreditCardFormLayoutMode.row
                  : CreditCardFormLayoutMode.column,
              cpfVisibility: widget.cpfVisibility,
              borderColor: widget.colorButton,
              labelColor: widget.colorTextField,
              labelTextNum: widget.labelTextNum,
              labelTextName: widget.labelTextName,
              labelTextExpData: widget.labelTextExpData,
              labelTextCVV: widget.labelTextCVV,
              labelTextCPF: widget.labelTextCPF,
              ccNumController: _ccNum,
              nameController: _nome,
              expDataController: _expData,
              cvvController: _cvv,
              cpfController: _cpf,
              numFocus: _numFocus,
              nameFocus: _nameFocus,
              expDateFocus: _expDateFocus,
              cvvFocus: _cvvFocus,
              cpfFocus: _cpfFocus,
              textFieldNam: textFieldNam,
              textFieldExpD: textFieldExpD,
              textFieldCvv: textFieldCvv,
              textFieldCpf: textFieldCpf,
              onNumberChanged: controller.changeNumber,
              onNameChanged: controller.changeName,
              onExpDataChanged: controller.changeExpData,
              onCvvChanged: controller.changeCVV,
              onCpfChanged: controller.changeCpf,
              validateNumber: controller.validateNumber,
              validateName: controller.validateName,
              validateExpData: controller.validateExpData,
              validateCVV: controller.validateCVV,
              validateCPF: controller.validateCPF,
              onSubmitIfValid: submitIfValid,
              mediaQuery: mediaQuery,
              ccType: ccType,
            ),
            SizedBox(height: 8),
            CreditCardSubmitButton(
              label: widget.labelTextButton,
              backgroundColor: widget.colorButton,
              foregroundColor: widget.colorTextButton,
              enabled: controller.isValid,
              onPressed: submitIfValid,
            ),
          ],
        ),
      ),
    );
  }
}
