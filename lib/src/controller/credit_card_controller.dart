import 'package:mobx/mobx.dart';

part 'credit_card_controller.g.dart';

class CreditCardController = _CreditCardControllerBase
    with _$CreditCardController;

abstract class _CreditCardControllerBase with Store {
  @observable
  String number;

  @action
  changeNumero(String value) => number = value;

  @observable
  String name;

  @action
  changeName(String value) => name = value;

  @observable
  String expData;

  @action
  changeExpData(String value) => expData = value;

  @observable
  String cvv;

  @action
  changeCVV(String value) => cvv = value;

  @observable
  String iconBand;

  @action
  changeIconBand(String value) => iconBand = value;
}
