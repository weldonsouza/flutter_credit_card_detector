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
  final double? marginTop;
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
  final InputDecoration? inputDecoration;
  final EdgeInsetsGeometry? inputContentPadding;
  final InputBorder? inputBorder;
  final InputBorder? inputEnabledBorder;
  final InputBorder? inputFocusedBorder;
  final InputBorder? inputErrorBorder;
  final InputBorder? inputFocusedErrorBorder;

  /// Quando `true`, exibe um ícone ao lado do campo do número para escanear o cartão.
  /// Requer [onCardScan] para o botão ficar habilitado.
  final bool showCardScanAction;

  /// Implementação no app (câmera, OCR, etc.). Retorne [CardScanResult] com os
  /// campos detectados; valores nulos ou vazios não alteram o formulário.
  final Future<CardScanResult?> Function()? onCardScan;

  final IconData cardScanIcon;

  /// Se null, usa [colorButton] do formulário.
  final Color? cardScanIconColor;

  final String? cardScanTooltip;

  /// Substitui o botão padrão ao lado do número. Recebe [CardScanButtonData] com
  /// `onPressed`, `loading` e estilos; use `data.onPressed` no seu widget.
  final CardScanButtonBuilder? cardScanButtonBuilder;

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
    this.marginTop,
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
    this.inputDecoration,
    this.inputContentPadding,
    this.inputBorder,
    this.inputEnabledBorder,
    this.inputFocusedBorder,
    this.inputErrorBorder,
    this.inputFocusedErrorBorder,
    this.showCardScanAction = false,
    this.onCardScan,
    this.cardScanIcon = Icons.photo_camera_rounded,
    this.cardScanIconColor,
    this.cardScanTooltip,
    this.cardScanButtonBuilder,
  });

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  bool _cardScanBusy = false;

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

  String _normalizeExpiryForMask(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 4) {
      return '${digits.substring(0, 2)}/${digits.substring(2, 4)}';
    }
    final trimmed = raw.trim();
    return trimmed.length <= 5 ? trimmed : trimmed.substring(0, 5);
  }

  void _applyCardScanResult(CardScanResult result, ControllerBase controller) {
    if (result.cardNumber != null && result.cardNumber!.isNotEmpty) {
      final digits = result.cardNumber!.replaceAll(RegExp(r'\D'), '');
      if (digits.isNotEmpty) {
        _ccNum.updateText(digits);
        controller.changeNumber(_ccNum.text);
      }
    }
    if (result.holderName != null && result.holderName!.trim().isNotEmpty) {
      _nome.text = result.holderName!.trim();
      controller.changeName(_nome.text);
    }
    if (result.expiryMmYy != null && result.expiryMmYy!.trim().isNotEmpty) {
      final normalized = _normalizeExpiryForMask(result.expiryMmYy!);
      _expData.updateText(normalized);
      controller.changeExpData(_expData.text);
    }
  }

  void _handleCardScan() {
    final future = widget.onCardScan;
    if (future == null || _cardScanBusy) return;
    setState(() => _cardScanBusy = true);
    future()
        .then((result) {
      if (!mounted || result == null) return;
      final controller = Provider.of<ControllerBase>(context, listen: false);
      _applyCardScanResult(result, controller);
      setState(() {});
    })
        .whenComplete(() {
      if (mounted) setState(() => _cardScanBusy = false);
    });
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

    final Widget? cardScanOverride = widget.showCardScanAction &&
            widget.cardScanButtonBuilder != null
        ? widget.cardScanButtonBuilder!(
            context,
            CardScanButtonData(
              enabled: widget.onCardScan != null,
              loading: _cardScanBusy,
              onPressed: (widget.onCardScan == null || _cardScanBusy)
                  ? null
                  : _handleCardScan,
              icon: widget.cardScanIcon,
              iconColor: widget.cardScanIconColor ?? widget.colorButton,
              tooltip: widget.cardScanTooltip,
            ),
          )
        : null;

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
            SizedBox(height: 8),
            CreditCardFormSection(
              layoutMode: widget.viewLayout
                  ? CreditCardFormLayoutMode.row
                  : CreditCardFormLayoutMode.column,
              cpfVisibility: widget.cpfVisibility,
              borderColor: widget.colorButton,
              labelColor: widget.colorTextField,
              inputDecoration: widget.inputDecoration,
              inputContentPadding: widget.inputContentPadding,
              inputBorder: widget.inputBorder,
              inputEnabledBorder: widget.inputEnabledBorder,
              inputFocusedBorder: widget.inputFocusedBorder,
              inputErrorBorder: widget.inputErrorBorder,
              inputFocusedErrorBorder: widget.inputFocusedErrorBorder,
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
              showCardScanAction: widget.showCardScanAction,
              cardScanBusy: _cardScanBusy,
              onCardScanPressed:
                  widget.onCardScan == null ? null : _handleCardScan,
              cardScanIcon: widget.cardScanIcon,
              cardScanIconColor:
                  widget.cardScanIconColor ?? widget.colorButton,
              cardScanTooltip: widget.cardScanTooltip,
              cardScanButtonOverride: cardScanOverride,
            ),
            CreditCardSubmitButton(
              label: widget.labelTextButton,
              backgroundColor: widget.colorButton,
              foregroundColor: widget.colorTextButton,
              enabled: controller.isValid,
              marginTop: widget.marginTop,
              onPressed: submitIfValid,
            ),
          ],
        ),
      ),
    );
  }
}
