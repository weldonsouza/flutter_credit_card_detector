import 'package:mobx/mobx.dart';
import 'credit_card_controller.dart';
import '../utils/credit_card_type_detector.dart';
import '../utils/globals.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  var creditCard = CreditCardController();
  var typeBand;
  var ccTypeBand;

  @computed
  bool get isValid {
    return validateNumero() == null &&
        validateName() == null &&
        validateExpData() == null &&
        validateCVV() == null &&
        validateCPF() == null &&
        validateIconBand() != 'unknown';
  }

  String validateNumero() {
    ccTypeBand = detectCCType(creditCard.number);

    if (creditCard.number.length < 19) {
      return textRequired;
    } else if (ccTypeBand == CreditCardType.unknown &&
        creditCard.iconBand == 'unknown') {
      return textSelectBand;
    }

    return null;
  }

  String validateName() {
    if (creditCard.name.isEmpty) {
      return textRequired;
    } else if (creditCard.name.length <= 5) {
      return textNameMin;
    } else if (int.tryParse(creditCard.name) != null) {
      return textIntroNameValid;
    }

    return null;
  }

  String validateExpData() {
    if (creditCard.expData.length != 5) {
      return textRequired;
    } else {
      List data = creditCard.expData.split("/");
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

  String validateCVV() {
    if (creditCard.cvv.length < 3) {
      return textRequired;
    }

    return null;
  }

  String validateCPF() {
    if (validateCpfVisibility == false) {
      return null;
    } else if (creditCard.cpf.length < 11) {
      return textRequired;
    }

    return null;
  }

  String validateIconBand() {
    ccTypeBand = detectCCType(creditCard.number);

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
        typeBand = creditCard.iconBand;
        break;
    }

    return typeBand;
  }

  dispose() {}
}
