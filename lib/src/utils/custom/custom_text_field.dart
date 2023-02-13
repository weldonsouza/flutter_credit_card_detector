import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final onChanged;
  final TextCapitalization textCapitalization;
  final FocusNode? focusScope;
  final String? labelText;
  final Color color;
  final Color colorText;
  final Color colorBord;
  final TextAlign textAlign;
  late final bool iconBool;
  final IconData? suffixIcon1;
  final IconData? suffixIcon2;
  final String Function()? errorText;
  final validate;
  final onEditingComplete;
  final Function()? onFieldSubmitted;
  final onTap;
  final onPressed;
  final bool? autoValidate;
  final bool readOnly;
  final Widget? prefixIcon;

  CustomTextField(
      {Key? key,
      this.width,
      this.height,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.maxLength,
      this.maxLines,
      this.focusNode,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none,
      this.focusScope,
      this.labelText,
      this.color = Colors.white,
      this.colorText = Colors.black54,
      this.colorBord = Colors.white30,
      this.textAlign = TextAlign.start,
      this.iconBool = false,
      this.suffixIcon1,
      this.suffixIcon2,
      this.errorText,
      this.validate,
      this.onTap,
      this.onPressed,
      this.readOnly = false,
      this.prefixIcon,
      this.autoValidate = true,
      this.onFieldSubmitted,
      this.onEditingComplete})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      //height: widget.height == null ? mediaQuery(context, 0.113) : widget.height,
      //margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color(0xFF4c4c4d).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        //autocorrect: widget.autoValidate,
        validator: widget.validate,
        readOnly: widget.readOnly,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        autofocus: false,
        cursorColor: widget.color,
        style: TextStyle(color: widget.colorText),
        obscureText: widget.iconBool,
        //textCapitalization: textCapitalization,
        //inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'[.,]'))],
        onFieldSubmitted: (v) {
          widget.onFieldSubmitted == null
              ? FocusScope.of(context).requestFocus(widget.focusScope)
              : widget.onFieldSubmitted;
        },
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        decoration: InputDecoration(
          counterText: '',
          //counter: Offstage(),
          //hintText: widget.labelText,
          prefixIcon: widget.prefixIcon == null ? null : widget.prefixIcon,
          suffixIcon: widget.suffixIcon1 == null
              ? widget.suffixIcon2 == null
                  ? null
                  : IconButton(
                      icon: Icon(widget.suffixIcon2,
                          color: widget.colorText, size: 20),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        // ignore: unnecessary_statements
                        widget.onPressed;
                      })
              : IconButton(
                  icon: Icon(
                    widget.iconBool ? widget.suffixIcon1 : widget.suffixIcon2,
                    color: widget.colorText,
                    size: 20,
                  ),
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      widget.iconBool = !widget.iconBool;
                    });
                  }),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorBord),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorBord),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.colorBord),
              borderRadius: BorderRadius.circular(8)),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: widget.colorText),
          errorText: widget.errorText == null ? null : widget.errorText!(),
          contentPadding:
              EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
        ),
      ),
    );
  }
}
