library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
var formatterMM = new DateFormat('MM');
var formatterYY = new DateFormat('yyyy');

int month = int.parse(formatterMM.format(now).toString());
int year = int.parse(formatterYY.format(now).toString());

String creditCardNumber = '';
String creditCardName = '';
String creditCardExpData = '';
String creditCardCVV = '';
String creditCardBand = '';
String creditCardCPF = '';

String? textRequired;
String? textSelectBand;
String? textNameMin;
String? textIntroNameValid;
String? textCardExpired;
String? textInvalidateMonth;
bool? validateCpfVisibility;

List<String> listBand = [];

mediaQuery(BuildContext context, double value, {String? direction}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  direction = direction ?? 'H';
  Size size = mediaQuery.size;
  if (direction.toUpperCase() == 'H') {
    return size.width * value;
  } else {
    return size.height * value;
  }
}
