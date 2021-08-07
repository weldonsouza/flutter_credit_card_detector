import 'package:flutter/material.dart';

import '../utils/credit_card_type_detector.dart';
import '../utils/globals.dart';

//********************************* VARIÁVEIS **********************************
final controllerName = TextEditingController(text: '');
final FocusNode productFocus = FocusNode();


class ControllerBase with ChangeNotifier {
  //------ Variáveis utilizadas no Provider ---------
  var typeBand;
  var ccTypeBand;
  late String number;
  late String name;
  late String expData;
  late String cvv;
  late String cpf;
  late String iconBand;

  //--------- Ataliza status do widget --------
  String get getNumber {
    return number;
  }

  String get getName {
    return name;
  }

  String get getExpData {
    return expData;
  }

  String get getCvv {
    return cvv;
  }

  String get getCpf {
    return cpf;
  }

  String get getIconBand {
    return iconBand;
  }

  //----------- Receber o dado do widget ----------
  changeNumero(String counter) {
    number = counter;
    notifyListeners();
  }

  changeName(String counter) {
    name = counter;
    notifyListeners();
  }

  changeExpData(String counter) {
    expData = counter;
    notifyListeners();
  }

  changeCVV(String counter) {
    cvv = counter;
    notifyListeners();
  }

  changeCpf(String counter) {
    cpf = counter;
    notifyListeners();
  }

  changeIconBand(String counter) {
    iconBand = counter;
    notifyListeners();
  }

  //--------- Validadores ---------
  bool get isValid {
    return validateNumero() == null &&
        validateName() == null &&
        validateExpData() == null &&
        validateCVV() == null &&
        validateCPF() == null &&
        validateIconBand() != 'unknown';
  }

  String? validateNumero() {
    ccTypeBand = detectCCType(number);
    if (number.length < 19) {
      return textRequired;
    } else if (ccTypeBand == CreditCardType.unknown && iconBand == 'unknown') {
      return textSelectBand;
    }

    return null;
  }

  String? validateName() {
    if (name.isEmpty) {
      return textRequired;
    } else if (name.length <= 5) {
      return textNameMin;
    } else if (int.tryParse(name) != null) {
      return textIntroNameValid;
    }

    return null;
  }

  String? validateExpData() {
    if (expData.length != 5) {
      return textRequired;
    } else {
      List data = expData.split("/");
      data[1] = "20" + data[1];

      if ((int.parse(data[0]) < month && int.parse(data[1]) <= year) ||
          (int.parse(data[1]) < year)) {
        return textCardExpired;
      } else if (int.parse(data[0]) < 1 || int.parse(data[0]) > 12) {
        return textInvalidateMonth;
      }
    }

    return null;
  }

  String? validateCVV() {
    if (cvv.length < 3) {
      return textRequired;
    }

    return null;
  }

  String? validateCPF() {
    if (validateCpfVisibility == false) {
      return null;
    } else if (cpf.length < 11) {
      return textRequired;
    }

    return null;
  }

  String validateIconBand() {
    ccTypeBand = detectCCType(number);

    switch (ccTypeBand) {
      case CreditCardType.amex:
        typeBand = 'Amex';
        break;

      case CreditCardType.aura:
        typeBand = 'Aura';
        break;

      case CreditCardType.dinersclub:
        typeBand = 'Diners';
        break;

      case CreditCardType.discover:
        typeBand = 'Discover';
        break;

      case CreditCardType.elo:
        typeBand = 'Elo';
        break;

      case CreditCardType.jcb:
        typeBand = 'JCB';
        break;

      case CreditCardType.mastercard:
        typeBand = 'Master';
        break;

      case CreditCardType.hiper:
        typeBand = 'Hiper';
        break;

      case CreditCardType.hipercard:
        typeBand = 'Hipercard';
        break;

      case CreditCardType.rupay:
        typeBand = 'Rupay';
        break;

      case CreditCardType.visa:
        typeBand = 'Visa';
        break;

      default:
        typeBand = iconBand;
        break;
    }

    return typeBand;
  }
}
