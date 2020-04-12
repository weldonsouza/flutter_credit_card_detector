import 'package:mobx/mobx.dart';

part 'credit_card.g.dart';

class CreditCard = _CreditCardBase with _$CreditCard;

abstract class _CreditCardBase with Store {
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
