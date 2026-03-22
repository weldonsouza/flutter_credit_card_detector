import 'package:flutter/material.dart';

import '../../utils/enums.dart';
import 'credit_card_input_field.dart';

class CreditCardFormSection extends StatelessWidget {
  final CreditCardFormLayoutMode layoutMode;
  final bool cpfVisibility;
  final Color borderColor;
  final Color labelColor;
  final String labelTextNum;
  final String labelTextName;
  final String labelTextExpData;
  final String labelTextCVV;
  final String labelTextCPF;
  final TextEditingController ccNumController;
  final TextEditingController nameController;
  final TextEditingController expDataController;
  final TextEditingController cvvController;
  final TextEditingController cpfController;
  final FocusNode numFocus;
  final FocusNode nameFocus;
  final FocusNode expDateFocus;
  final FocusNode cvvFocus;
  final FocusNode cpfFocus;
  final GlobalKey textFieldNam;
  final GlobalKey textFieldExpD;
  final GlobalKey textFieldCvv;
  final GlobalKey textFieldCpf;
  final ValueChanged<String> onNumberChanged;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onExpDataChanged;
  final ValueChanged<String> onCvvChanged;
  final ValueChanged<String> onCpfChanged;
  final String? Function()? validateNumber;
  final String? Function()? validateName;
  final String? Function()? validateExpData;
  final String? Function()? validateCVV;
  final String? Function()? validateCPF;
  final VoidCallback onSubmitIfValid;
  final dynamic Function(BuildContext, double, {String? direction}) mediaQuery;
  final CreditCardType ccType;

  final bool showCardScanAction;
  final bool cardScanBusy;
  final VoidCallback? onCardScanPressed;
  final IconData cardScanIcon;
  final Color? cardScanIconColor;
  final String? cardScanTooltip;

  /// Quando não null, substitui o botão padrão gerado pelo pacote.
  final Widget? cardScanButtonOverride;

  final InputDecoration? inputDecoration;
  final EdgeInsetsGeometry? inputContentPadding;
  final InputBorder? inputBorder;
  final InputBorder? inputEnabledBorder;
  final InputBorder? inputFocusedBorder;
  final InputBorder? inputErrorBorder;
  final InputBorder? inputFocusedErrorBorder;

  const CreditCardFormSection({
    super.key,
    required this.layoutMode,
    required this.cpfVisibility,
    required this.borderColor,
    required this.labelColor,
    required this.labelTextNum,
    required this.labelTextName,
    required this.labelTextExpData,
    required this.labelTextCVV,
    required this.labelTextCPF,
    required this.ccNumController,
    required this.nameController,
    required this.expDataController,
    required this.cvvController,
    required this.cpfController,
    required this.numFocus,
    required this.nameFocus,
    required this.expDateFocus,
    required this.cvvFocus,
    required this.cpfFocus,
    required this.textFieldNam,
    required this.textFieldExpD,
    required this.textFieldCvv,
    required this.textFieldCpf,
    required this.onNumberChanged,
    required this.onNameChanged,
    required this.onExpDataChanged,
    required this.onCvvChanged,
    required this.onCpfChanged,
    required this.validateNumber,
    required this.validateName,
    required this.validateExpData,
    required this.validateCVV,
    required this.validateCPF,
    required this.onSubmitIfValid,
    required this.mediaQuery,
    required this.ccType,
    this.showCardScanAction = false,
    this.cardScanBusy = false,
    this.onCardScanPressed,
    this.cardScanIcon = Icons.photo_camera_rounded,
    this.cardScanIconColor,
    this.cardScanTooltip,
    this.cardScanButtonOverride,
    this.inputDecoration,
    this.inputContentPadding,
    this.inputBorder,
    this.inputEnabledBorder,
    this.inputFocusedBorder,
    this.inputErrorBorder,
    this.inputFocusedErrorBorder,
  });

  int get _cvvMaxLength => ccType == CreditCardType.amex || ccType == CreditCardType.discover ? 4 : 3;

  Color get _scanIconColor => cardScanIconColor ?? borderColor;

  Widget _buildScanActionButton(BuildContext context) {
    final enabled = !cardScanBusy && onCardScanPressed != null;
    final color = _scanIconColor;
    final bg = enabled
        ? color.withValues(alpha: 0.12)
        : Theme.of(context).disabledColor.withValues(alpha: 0.08);

    final icon = cardScanBusy
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: color,
            ),
          )
        : Icon(
            cardScanIcon,
            color: color,
            size: 24,
          );

    return Tooltip(
      message: cardScanTooltip ?? 'Preencher com a câmera',
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onCardScanPressed : null,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(
    BuildContext context, {
    double? fixedWidth,
    GlobalKey? nextTextFieldView,
  }) {
    final field = CreditCardInputField(
      width: showCardScanAction ? null : fixedWidth,
      controller: ccNumController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      digitsOnly: true,
      maxLength: 19,
      focusNode: numFocus,
      onChanged: onNumberChanged,
      textCapitalization: TextCapitalization.none,
      nextFocusNode: nameFocus,
      labelText: labelTextNum,
      nextTextFieldView: nextTextFieldView,
      errorText: validateNumber,
      borderColor: borderColor,
      labelColor: labelColor,
      decoration: inputDecoration,
      contentPadding: inputContentPadding,
      border: inputBorder,
      enabledBorder: inputEnabledBorder,
      focusedBorder: inputFocusedBorder,
      errorBorder: inputErrorBorder,
      focusedErrorBorder: inputFocusedErrorBorder,
      onSubmitIfValid: onSubmitIfValid,
    );

    if (!showCardScanAction) {
      if (fixedWidth != null) {
        return SizedBox(width: fixedWidth, child: field);
      }
      return field;
    }

    final scanBtn =
        cardScanButtonOverride ?? _buildScanActionButton(context);

    // Alinha o botão ao topo do campo (Outline + label); `center` desloca com erro abaixo.
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: field),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: scanBtn,
        ),
      ],
    );

    if (fixedWidth != null) {
      return SizedBox(
        width: fixedWidth + 8 + 44,
        child: row,
      );
    }

    return row;
  }

  @override
  Widget build(BuildContext context) {
    if (layoutMode == CreditCardFormLayoutMode.row) {
      return Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNumberField(
                context,
                fixedWidth: mediaQuery(context, 0.7),
                nextTextFieldView: textFieldNam,
              ),
              const SizedBox(width: 10),
              CreditCardInputField(
                width: mediaQuery(context, 0.8),
                controller: nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLength: 25,
                focusNode: nameFocus,
                onChanged: onNameChanged,
                textCapitalization: TextCapitalization.characters,
                nextFocusNode: expDateFocus,
                labelText: labelTextName,
                nextTextFieldView: textFieldExpD,
                errorText: validateName,
                borderColor: borderColor,
                labelColor: labelColor,
                decoration: inputDecoration,
                contentPadding: inputContentPadding,
                border: inputBorder,
                enabledBorder: inputEnabledBorder,
                focusedBorder: inputFocusedBorder,
                errorBorder: inputErrorBorder,
                focusedErrorBorder: inputFocusedErrorBorder,
                onSubmitIfValid: onSubmitIfValid,
              ),
              const SizedBox(width: 10),
              CreditCardInputField(
                width: mediaQuery(context, 0.45),
                controller: expDataController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 5,
                focusNode: expDateFocus,
                onChanged: onExpDataChanged,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: cvvFocus,
                labelText: labelTextExpData,
                nextTextFieldView: textFieldCvv,
                errorText: validateExpData,
                borderColor: borderColor,
                labelColor: labelColor,
                decoration: inputDecoration,
                contentPadding: inputContentPadding,
                border: inputBorder,
                enabledBorder: inputEnabledBorder,
                focusedBorder: inputFocusedBorder,
                errorBorder: inputErrorBorder,
                focusedErrorBorder: inputFocusedErrorBorder,
                onSubmitIfValid: onSubmitIfValid,
              ),
              const SizedBox(width: 10),
              CreditCardInputField(
                width: mediaQuery(context, 0.45),
                controller: cvvController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: _cvvMaxLength,
                focusNode: cvvFocus,
                onChanged: onCvvChanged,
                textCapitalization: TextCapitalization.none,
                nextFocusNode: cpfFocus,
                labelText: labelTextCVV,
                nextTextFieldView: textFieldCpf,
                errorText: validateCVV,
                borderColor: borderColor,
                labelColor: labelColor,
                decoration: inputDecoration,
                contentPadding: inputContentPadding,
                border: inputBorder,
                enabledBorder: inputEnabledBorder,
                focusedBorder: inputFocusedBorder,
                errorBorder: inputErrorBorder,
                focusedErrorBorder: inputFocusedErrorBorder,
                onSubmitIfValid: onSubmitIfValid,
              ),
              cpfVisibility ? const SizedBox(width: 10) : const SizedBox.shrink(),
              cpfVisibility
                  ? CreditCardInputField(
                      width: mediaQuery(context, 0.7),
                      controller: cpfController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 11,
                      focusNode: cpfFocus,
                      onChanged: onCpfChanged,
                      textCapitalization: TextCapitalization.characters,
                      labelText: labelTextCPF,
                      errorText: validateCPF,
                      borderColor: borderColor,
                      labelColor: labelColor,
                      decoration: inputDecoration,
                      contentPadding: inputContentPadding,
                      border: inputBorder,
                      enabledBorder: inputEnabledBorder,
                      focusedBorder: inputFocusedBorder,
                      errorBorder: inputErrorBorder,
                      focusedErrorBorder: inputFocusedErrorBorder,
                      onSubmitIfValid: onSubmitIfValid,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        _buildNumberField(context),
        const SizedBox(height: 8),
        CreditCardInputField(
          controller: nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          maxLength: 25,
          focusNode: nameFocus,
          onChanged: onNameChanged,
          textCapitalization: TextCapitalization.characters,
          nextFocusNode: expDateFocus,
          labelText: labelTextName,
          errorText: validateName,
          borderColor: borderColor,
          labelColor: labelColor,
          decoration: inputDecoration,
          contentPadding: inputContentPadding,
          border: inputBorder,
          enabledBorder: inputEnabledBorder,
          focusedBorder: inputFocusedBorder,
          errorBorder: inputErrorBorder,
          focusedErrorBorder: inputFocusedErrorBorder,
          onSubmitIfValid: onSubmitIfValid,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CreditCardInputField(
              width: mediaQuery(context, 0.45),
              controller: expDataController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 5,
              focusNode: expDateFocus,
              onChanged: onExpDataChanged,
              textCapitalization: TextCapitalization.none,
              nextFocusNode: cvvFocus,
              labelText: labelTextExpData,
              errorText: validateExpData,
              borderColor: borderColor,
              labelColor: labelColor,
              decoration: inputDecoration,
              contentPadding: inputContentPadding,
              border: inputBorder,
              enabledBorder: inputEnabledBorder,
              focusedBorder: inputFocusedBorder,
              errorBorder: inputErrorBorder,
              focusedErrorBorder: inputFocusedErrorBorder,
              onSubmitIfValid: onSubmitIfValid,
            ),
            CreditCardInputField(
              width: mediaQuery(context, 0.45),
              controller: cvvController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: _cvvMaxLength,
              focusNode: cvvFocus,
              onChanged: onCvvChanged,
              textCapitalization: TextCapitalization.none,
              nextFocusNode: cpfFocus,
              labelText: labelTextCVV,
              nextTextFieldView: textFieldCpf,
              errorText: validateCVV,
              borderColor: borderColor,
              labelColor: labelColor,
              decoration: inputDecoration,
              contentPadding: inputContentPadding,
              border: inputBorder,
              enabledBorder: inputEnabledBorder,
              focusedBorder: inputFocusedBorder,
              errorBorder: inputErrorBorder,
              focusedErrorBorder: inputFocusedErrorBorder,
              onSubmitIfValid: onSubmitIfValid,
            ),
          ],
        ),
        cpfVisibility ? const SizedBox(height: 8) : const SizedBox.shrink(),
        cpfVisibility
            ? CreditCardInputField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                digitsOnly: true,
                maxLength: 11,
                focusNode: cpfFocus,
                onChanged: onCpfChanged,
                textCapitalization: TextCapitalization.characters,
                labelText: labelTextCPF,
                errorText: validateCPF,
                borderColor: borderColor,
                labelColor: labelColor,
                decoration: inputDecoration,
                contentPadding: inputContentPadding,
                border: inputBorder,
                enabledBorder: inputEnabledBorder,
                focusedBorder: inputFocusedBorder,
                errorBorder: inputErrorBorder,
                focusedErrorBorder: inputFocusedErrorBorder,
                onSubmitIfValid: onSubmitIfValid,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
