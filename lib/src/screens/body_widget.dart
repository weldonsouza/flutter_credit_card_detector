library flutter_credit_card_detector;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../utils/credit_card_type_detector.dart';
import '../utils/globals.dart';

export 'package:flutter_masked_text/flutter_masked_text.dart';
export 'package:flutter_mobx/flutter_mobx.dart';
export 'package:provider/provider.dart';

class BodyWidget extends StatefulWidget {
  final String titleCreditCard;
  final String labelTextValidate;
  final Color colorCardSelect;
  final Color colorCreditWhite;
  final Color colorCreditBlack;

  const BodyWidget({
    Key key,
    this.titleCreditCard,
    this.labelTextValidate,
    this.colorCardSelect,
    this.colorCreditWhite,
    this.colorCreditBlack,
  }) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  CreditCardType currType;

  _iconBand(controller) {
    double sizeBand = mediaQuery(context, 0.09);
    Widget icon;
    var currType = detectCCType(controller.creditCard.number);

    switch (currType) {
      case CreditCardType.amex:
        icon = Image(
          image: AssetImage("assets/amex.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.aura:
        icon = Image(
          image: AssetImage("assets/aura.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.dinersclub:
        icon = Image(
          image: AssetImage("assets/dinersclub.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.discover:
        icon = Image(
          image: AssetImage("assets/discover.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.elo:
        icon = Image(
          image: AssetImage("assets/elo.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.jcb:
        icon = Image(
          image: AssetImage("assets/jcb.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.mastercard:
        icon = Image(
          image: AssetImage("assets/mastercard.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.hiper:
        icon = Image(
          image: AssetImage("assets/hiper.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.hipercard:
        icon = Image(
          image: AssetImage("assets/hipercard.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.rupay:
        icon = Image(
          image: AssetImage("assets/rupay.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      case CreditCardType.visa:
        icon = Image(
          image: AssetImage("assets/visa.png",
              package: 'flutter_credit_card_detector'),
          width: sizeBand,
        );
        break;

      default:
        Widget widget;
        if (currType == CreditCardType.unknown &&
            controller.creditCard.number.length < 4) {
          widget = Container(
            color: Color(0x00000000),
          );
        } else if (controller.creditCard.iconBand != 'unknown' &&
            controller.creditCard.number.length < 19) {
          widget = Container(
            color: Color(0x00000000),
          );
        } else {
          widget = Image(
            image: AssetImage("assets/${controller.creditCard.iconBand}.png",
                package: 'flutter_credit_card_detector'),
            width: sizeBand,
          );
        }
        icon = widget;
        break;
    }

    return icon;
  }

  _creditCardWidget(controller) {
    bool cardColor = false;

    if (controller.creditCard.iconBand != 'unknown' &&
        controller.creditCard.number.length < 19) {
      controller.creditCard.iconBand = 'unknown';
      currType = CreditCardType.unknown;
      cardColor = true;
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          detectCCType(controller.creditCard.number) ==
                      CreditCardType.unknown &&
                  controller.creditCard.number.length > 4
              ? Observer(builder: (_) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      _gestureDetectorCard(controller, 'visa',
                          CreditCardType.visa, Colors.grey, cardColor),
                      _gestureDetectorCard(controller, 'mastercard',
                          CreditCardType.mastercard, null, cardColor),
                      _gestureDetectorCard(controller, 'amex',
                          CreditCardType.amex, null, cardColor),
                      _gestureDetectorCard(controller, 'elo',
                          CreditCardType.elo, Colors.grey, cardColor),
                      _gestureDetectorCard(controller, 'dinersclub',
                          CreditCardType.dinersclub, null, cardColor),
                      _gestureDetectorCard(controller, 'discover',
                          CreditCardType.discover, Colors.grey, cardColor),
                      _gestureDetectorCard(controller, 'jcb',
                          CreditCardType.jcb, null, cardColor),
                      _gestureDetectorCard(controller, 'aura',
                          CreditCardType.aura, null, cardColor),
                      _gestureDetectorCard(controller, 'hiper',
                          CreditCardType.hiper, null, cardColor),
                      _gestureDetectorCard(controller, 'hipercard',
                          CreditCardType.hipercard, null, cardColor),
                      _gestureDetectorCard(controller, 'rupay',
                          CreditCardType.rupay, null, cardColor),
                    ],
                  );
                })
              : Container()
        ],
      ),
    );
  }

  _gestureDetectorCard(
      controller, image, creditCardType, colorCard, cardColor) {
    return GestureDetector(
      onTap: () {
        controller.creditCard.iconBand = image;
        currType = creditCardType;
        setState(() {});
      },
      child: Card(
        color: cardColor == false && currType == creditCardType
            ? widget.colorCardSelect
            : Colors.white,
        child: Container(
          width: mediaQuery(context, 0.1),
          height: mediaQuery(context, 0.1),
          child: Stack(
            children: <Widget>[
              Radio(
                value: currType,
                groupValue: CreditCardType.visa,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          color:
                              cardColor == false && currType == creditCardType
                                  ? widget.colorCardSelect
                                  : Colors.white,
                          child: Image(
                            image: AssetImage('assets/$image.png',
                                package: 'flutter_credit_card_detector'),
                            width: mediaQuery(context, 0.08),
                            height: mediaQuery(context, 0.08),
                            color: colorCard,
                            alignment: Alignment.center,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);

    return Column(
      children: <Widget>[
        Container(
          height: mediaQuery(context, 0.6),
          width: mediaQuery(context, 0.9),
          child: Center(
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: mediaQuery(context, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      widget.colorCreditWhite,
                      widget.colorCreditBlack,
                    ],
                  ),
                ),

                // Overlay with credit card info
                child: Container(
                  height: mediaQuery(context, 0.5),
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.all(mediaQuery(context, 0.05)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: mediaQuery(context, 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.titleCreditCard,
                                style: TextStyle(
                                    fontSize: mediaQuery(context, 0.04),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Observer(builder: (_) {
                                return _iconBand(controller);
                              }),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                height: mediaQuery(context, 0.13),
                                alignment: Alignment.centerLeft,
                                child: Image(
                                    image: AssetImage(
                                        'assets/creditCardChip.png',
                                        package:
                                            'flutter_credit_card_detector'),
                                    width: mediaQuery(context, 0.11))),
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                height: mediaQuery(context, 0.13),
                                alignment: Alignment.centerLeft,
                                child: Image(
                                    image: AssetImage('assets/contactless.png',
                                        package:
                                            'flutter_credit_card_detector'),
                                    color: Colors.white,
                                    width: mediaQuery(context, 0.05))),
                          ],
                        ),

                        //Numero
                        Observer(builder: (_) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.creditCard.number == null ||
                                      controller.creditCard.number == ''
                                  ? 'XXXX XXXX XXXX XXXX'
                                  : controller.creditCard.number,
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: mediaQuery(context, 0.06),
                              ),
                            ),
                          );
                        }),

                        //Data e CVV
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Observer(builder: (_) {
                              return Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      controller.creditCard.expData == null
                                          ? ''
                                          : controller.creditCard.expData,
                                      style: TextStyle(
                                        fontSize: mediaQuery(context, 0.03),
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                    Text(
                                      widget.labelTextValidate,
                                      style: TextStyle(
                                        fontSize: mediaQuery(context, 0.02),
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            Observer(builder: (_) {
                              return Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        controller.creditCard.cvv == null
                                            ? ''
                                            : controller.creditCard.cvv,
                                        style: TextStyle(
                                          fontSize: mediaQuery(context, 0.03),
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      Text(
                                        "CVC",
                                        style: TextStyle(
                                          fontSize: mediaQuery(context, 0.02),
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                          ],
                        ),

                        //Nome
                        Observer(builder: (_) {
                          return Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    controller.creditCard.name == null
                                        ? ''
                                        : controller.creditCard.name
                                            .toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.normal,
                                      fontSize: mediaQuery(context, 0.045),
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ));
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Observer(builder: (_) {
          return _creditCardWidget(controller);
        }),
      ],
    );
  }
}
