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
    this.inputDecoration,
    this.inputContentPadding,
    this.inputBorder,
    this.inputEnabledBorder,
    this.inputFocusedBorder,
    this.inputErrorBorder,
    this.inputFocusedErrorBorder,
  });

  int get _cvvMaxLength => ccType == CreditCardType.amex || ccType == CreditCardType.discover ? 4 : 3;

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
              CreditCardInputField(
                width: mediaQuery(context, 0.7),
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
                nextTextFieldView: textFieldNam,
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
        CreditCardInputField(
          controller: ccNumController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          maxLength: 19,
          focusNode: numFocus,
          onChanged: onNumberChanged,
          digitsOnly: true,
          textCapitalization: TextCapitalization.none,
          nextFocusNode: nameFocus,
          labelText: labelTextNum,
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
        ),
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
