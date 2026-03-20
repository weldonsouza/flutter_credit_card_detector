import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardInputField extends StatelessWidget {
  final Key? fieldKey;
  final double? width;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final FocusNode? nextFocusNode;
  final String labelText;
  final GlobalKey? nextTextFieldView;
  final bool digitsOnly;
  final String? Function()? errorText;
  final Color borderColor;
  final Color labelColor;
  final VoidCallback? onSubmitIfValid;

  const CreditCardInputField({
    super.key,
    this.fieldKey,
    this.width,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    this.maxLength,
    this.focusNode,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.nextFocusNode,
    required this.labelText,
    this.nextTextFieldView,
    this.digitsOnly = false,
    this.errorText,
    required this.borderColor,
    required this.labelColor,
    this.onSubmitIfValid,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        key: fieldKey,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        focusNode: focusNode,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        inputFormatters: digitsOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
        onFieldSubmitted: (_) => onSubmitIfValid?.call(),
        onEditingComplete: () {
          if (nextTextFieldView == null) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).requestFocus(nextFocusNode);
            nextTextFieldView?.currentContext
                ?.findRenderObject()
                ?.showOnScreen(duration: const Duration(seconds: 0));
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor),
          errorText: errorText == null ? null : errorText!(),
        ),
      ),
    );
  }
}
