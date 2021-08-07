
import 'package:flutter/material.dart';

class CreditCardControllerBase {
  late String number;
  changeNumero(String value) => number = value;

  late String name;
  changeName(String value) => name = value;

  late String expData;
  changeExpData(String value) => expData = value;

  late String cvv;
  changeCVV(String value) => cvv = value;

  late String cpf;
  changeCpf(String value) => cpf = value;

  late String iconBand;
  changeIconBand(String value) => iconBand = value;
}
