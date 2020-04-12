// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreditCard on _CreditCardBase, Store {
  final _$numberAtom = Atom(name: '_CreditCardBase.number');

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

  final _$nameAtom = Atom(name: '_CreditCardBase.name');

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

  final _$expDataAtom = Atom(name: '_CreditCardBase.expData');

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

  final _$cvvAtom = Atom(name: '_CreditCardBase.cvv');

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

  final _$iconBandAtom = Atom(name: '_CreditCardBase.iconBand');

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

  final _$_CreditCardBaseActionController =
      ActionController(name: '_CreditCardBase');

  @override
  dynamic changeNumero(String value) {
    final _$actionInfo = _$_CreditCardBaseActionController.startAction();
    try {
      return super.changeNumero(value);
    } finally {
      _$_CreditCardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(String value) {
    final _$actionInfo = _$_CreditCardBaseActionController.startAction();
    try {
      return super.changeName(value);
    } finally {
      _$_CreditCardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeExpData(String value) {
    final _$actionInfo = _$_CreditCardBaseActionController.startAction();
    try {
      return super.changeExpData(value);
    } finally {
      _$_CreditCardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCVV(String value) {
    final _$actionInfo = _$_CreditCardBaseActionController.startAction();
    try {
      return super.changeCVV(value);
    } finally {
      _$_CreditCardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIconBand(String value) {
    final _$actionInfo = _$_CreditCardBaseActionController.startAction();
    try {
      return super.changeIconBand(value);
    } finally {
      _$_CreditCardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'number: ${number.toString()},name: ${name.toString()},expData: ${expData.toString()},cvv: ${cvv.toString()},iconBand: ${iconBand.toString()}';
    return '{$string}';
  }
}
