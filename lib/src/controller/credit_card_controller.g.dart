// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreditCardController on _CreditCardControllerBase, Store {
  final _$numberAtom = Atom(name: '_CreditCardControllerBase.number');

  @override
  String get number {
    _$numberAtom.context.enforceReadPolicy(_$numberAtom);
    _$numberAtom.reportObserved();
    return super.number;
  }

  @override
  set number(String value) {
    _$numberAtom.context.conditionallyRunInAction(() {
      super.number = value;
      _$numberAtom.reportChanged();
    }, _$numberAtom, name: '${_$numberAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_CreditCardControllerBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$expDataAtom = Atom(name: '_CreditCardControllerBase.expData');

  @override
  String get expData {
    _$expDataAtom.context.enforceReadPolicy(_$expDataAtom);
    _$expDataAtom.reportObserved();
    return super.expData;
  }

  @override
  set expData(String value) {
    _$expDataAtom.context.conditionallyRunInAction(() {
      super.expData = value;
      _$expDataAtom.reportChanged();
    }, _$expDataAtom, name: '${_$expDataAtom.name}_set');
  }

  final _$cvvAtom = Atom(name: '_CreditCardControllerBase.cvv');

  @override
  String get cvv {
    _$cvvAtom.context.enforceReadPolicy(_$cvvAtom);
    _$cvvAtom.reportObserved();
    return super.cvv;
  }

  @override
  set cvv(String value) {
    _$cvvAtom.context.conditionallyRunInAction(() {
      super.cvv = value;
      _$cvvAtom.reportChanged();
    }, _$cvvAtom, name: '${_$cvvAtom.name}_set');
  }

  final _$cpfAtom = Atom(name: '_CreditCardControllerBase.cpf');

  @override
  String get cpf {
    _$cpfAtom.context.enforceReadPolicy(_$cpfAtom);
    _$cpfAtom.reportObserved();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.context.conditionallyRunInAction(() {
      super.cpf = value;
      _$cpfAtom.reportChanged();
    }, _$cpfAtom, name: '${_$cpfAtom.name}_set');
  }

  final _$iconBandAtom = Atom(name: '_CreditCardControllerBase.iconBand');

  @override
  String get iconBand {
    _$iconBandAtom.context.enforceReadPolicy(_$iconBandAtom);
    _$iconBandAtom.reportObserved();
    return super.iconBand;
  }

  @override
  set iconBand(String value) {
    _$iconBandAtom.context.conditionallyRunInAction(() {
      super.iconBand = value;
      _$iconBandAtom.reportChanged();
    }, _$iconBandAtom, name: '${_$iconBandAtom.name}_set');
  }

  final _$_CreditCardControllerBaseActionController =
      ActionController(name: '_CreditCardControllerBase');

  @override
  dynamic changeNumero(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeNumero(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeName(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeExpData(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeExpData(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCVV(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeCVV(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCpf(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeCpf(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIconBand(String value) {
    final _$actionInfo =
        _$_CreditCardControllerBaseActionController.startAction();
    try {
      return super.changeIconBand(value);
    } finally {
      _$_CreditCardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'number: ${number.toString()},name: ${name.toString()},expData: ${expData.toString()},cvv: ${cvv.toString()},cpf: ${cpf.toString()},iconBand: ${iconBand.toString()}';
    return '{$string}';
  }
}
