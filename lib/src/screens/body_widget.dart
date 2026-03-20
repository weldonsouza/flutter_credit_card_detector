library flutter_credit_card_detector;

import 'package:flutter/material.dart';

import '../../flutter_credit_card_detector.dart';
import 'widgets/card_brand_option.dart';

export 'package:provider/provider.dart';

class BodyWidget extends StatefulWidget {
  final String titleCreditCard;
  final String labelTextValidate;
  final Color colorCardSelect;
  final Color colorCreditWhite;
  final Color colorCreditBlack;
  final double textSizeNumber;
  final double textSizeName;
  final double textSizeMonth;
  final double textSizeCVC;
  final String? fontFamily;
  final TextStyle? titleTextStyle;
  final TextStyle? numberTextStyle;
  final TextStyle? nameTextStyle;
  final TextStyle? detailLabelTextStyle;
  final TextStyle? detailValueTextStyle;
  final double cardBorderRadius;
  final double cardElevation;
  final EdgeInsetsGeometry cardMargin;
  final EdgeInsetsGeometry cardContentPadding;
  final CreditCardStylePreset cardStylePreset;
  final List<String> listBand;

  const BodyWidget({
    super.key,
    required this.titleCreditCard,
    required this.labelTextValidate,
    required this.colorCardSelect,
    required this.colorCreditWhite,
    required this.colorCreditBlack,
    required this.textSizeNumber,
    required this.textSizeName,
    required this.textSizeMonth,
    required this.textSizeCVC,
    this.fontFamily,
    this.titleTextStyle,
    this.numberTextStyle,
    this.nameTextStyle,
    this.detailLabelTextStyle,
    this.detailValueTextStyle,
    this.cardBorderRadius = 12,
    this.cardElevation = 3,
    this.cardMargin = const EdgeInsets.symmetric(horizontal: 5),
    this.cardContentPadding = const EdgeInsets.all(16),
    this.cardStylePreset = CreditCardStylePreset.custom,
    required this.listBand,
  });

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  static const Map<CreditCardType, String> _brandAssetByType = {
    CreditCardType.amex: 'amex',
    CreditCardType.aura: 'aura',
    CreditCardType.dinersclub: 'dinersclub',
    CreditCardType.discover: 'discover',
    CreditCardType.elo: 'elo',
    CreditCardType.jcb: 'jcb',
    CreditCardType.mastercard: 'mastercard',
    CreditCardType.hiper: 'hiper',
    CreditCardType.hipercard: 'hipercard',
    CreditCardType.rupay: 'rupay',
    CreditCardType.visa: 'visa',
  };

  static const List<_BrandConfig> _selectableBrands = [
    _BrandConfig('visa', CreditCardType.visa, Colors.grey),
    _BrandConfig('mastercard', CreditCardType.mastercard),
    _BrandConfig('amex', CreditCardType.amex),
    _BrandConfig('elo', CreditCardType.elo, Colors.grey),
    _BrandConfig('dinersclub', CreditCardType.dinersclub),
    _BrandConfig('discover', CreditCardType.discover, Colors.grey),
    _BrandConfig('jcb', CreditCardType.jcb),
    _BrandConfig('aura', CreditCardType.aura),
    _BrandConfig('hiper', CreditCardType.hiper),
    _BrandConfig('hipercard', CreditCardType.hipercard),
    _BrandConfig('rupay', CreditCardType.rupay),
    _BrandConfig('maestro', CreditCardType.maestro),
    _BrandConfig('unionpay', CreditCardType.unionpay),
    _BrandConfig('troy', CreditCardType.troy),
    _BrandConfig('dankort', CreditCardType.dankort),
    _BrandConfig('uatp', CreditCardType.uatp),
  ];

  late CreditCardType currType;
  var imageSelect = 'unknown';

  @override
  void initState() {
    super.initState();
    currType = CreditCardType.unknown;
  }

  List<Color> _effectiveGradientColors() {
    switch (widget.cardStylePreset) {
      case CreditCardStylePreset.modern:
        return const [Color(0xFF182848), Color(0xFF4B6CB7)];
      case CreditCardStylePreset.glass:
        return const [Color(0x99253B66), Color(0xAA1B1B1B)];
      case CreditCardStylePreset.midnight:
        return const [Color(0xFF0F2027), Color(0xFF203A43)];
      case CreditCardStylePreset.custom:
        return [widget.colorCreditWhite, widget.colorCreditBlack];
    }
  }

  double _effectiveBorderRadius() {
    switch (widget.cardStylePreset) {
      case CreditCardStylePreset.modern:
        return 18;
      case CreditCardStylePreset.glass:
        return 22;
      case CreditCardStylePreset.midnight:
        return 16;
      case CreditCardStylePreset.custom:
        return widget.cardBorderRadius;
    }
  }

  double _effectiveElevation() {
    switch (widget.cardStylePreset) {
      case CreditCardStylePreset.modern:
        return 7;
      case CreditCardStylePreset.glass:
        return 2;
      case CreditCardStylePreset.midnight:
        return 6;
      case CreditCardStylePreset.custom:
        return widget.cardElevation;
    }
  }

  EdgeInsetsGeometry _effectiveCardPadding() {
    switch (widget.cardStylePreset) {
      case CreditCardStylePreset.modern:
      case CreditCardStylePreset.midnight:
        return const EdgeInsets.fromLTRB(18, 16, 18, 14);
      case CreditCardStylePreset.glass:
        return const EdgeInsets.fromLTRB(20, 18, 20, 16);
      case CreditCardStylePreset.custom:
        return widget.cardContentPadding;
    }
  }

  Widget _iconBand(dynamic controller) {
    final double sizeBand = mediaQuery(context, 0.09);
    final CreditCardType detectedType = detectCCType(controller.number);

    final assetName = _brandAssetByType[detectedType];
    if (assetName != null) {
      return Image(
        image: AssetImage(
          'assets/$assetName.png',
          package: 'flutter_credit_card_detector',
        ),
        width: sizeBand,
      );
    }

    if ((detectedType == CreditCardType.unknown && controller.number.length < 4) ||
        (controller.iconBand != 'unknown' && controller.number.length < 19)) {
      return const SizedBox.shrink();
    }

    return Image(
      image: AssetImage(
        'assets/$imageSelect.png',
        package: 'flutter_credit_card_detector',
      ),
      width: sizeBand,
    );
  }

  Widget _creditCardWidget(dynamic controller) {
    bool cardColor = false;

    if (controller.iconBand != 'unknown' && controller.number.length < 19) {
      controller.iconBand = 'unknown';
      currType = CreditCardType.unknown;
      cardColor = true;
    }

    final shouldShowSelector = detectCCType(controller.number) == CreditCardType.unknown &&
        controller.number.length > 4;
    final brandCards = _selectableBrands
        .where((brand) => listBand.contains(brand.key))
        .map((brand) => _gestureDetectorCard(
            controller,
            brand.key,
            brand.type,
            brand.tint,
            cardColor,
          ),
        )
        .toList();

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          shouldShowSelector
              ? Wrap(
                  alignment: WrapAlignment.center,
                  children: brandCards,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _gestureDetectorCard(
    dynamic controller,
    String image,
    CreditCardType creditCardType,
    Color? colorCard,
    bool cardColor,
  ) {
    final bool isSelected = cardColor == false && currType == creditCardType;

    return CardBrandOption(
      image: image,
      isSelected: isSelected,
      selectedColor: widget.colorCardSelect,
      imageTint: colorCard,
      onTap: () {
        controller.iconBand = image;
        currType = creditCardType;
        controller.changeIconBand(image);

        setState(() {
          imageSelect = image;
        });
      },
      width: mediaQuery(context, 0.12),
      height: mediaQuery(context, 0.11),
      imageSize: mediaQuery(context, 0.08),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ControllerBase>(context);
    final gradientColors = _effectiveGradientColors();
    final cardRadius = _effectiveBorderRadius();
    final cardElevation = _effectiveElevation();
    final cardPadding = _effectiveCardPadding();
    final textColor = widget.cardStylePreset == CreditCardStylePreset.glass
        ? Colors.white.withAlpha(240)
        : Colors.white;

    return Column(
      children: <Widget>[
        SizedBox(
          height: mediaQuery(context, 0.6),
          width: mediaQuery(context, 0.9),
          child: Center(
            child: Card(
              elevation: cardElevation,
              margin: widget.cardMargin,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardRadius),
              ),
              child: Container(
                width: mediaQuery(context, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(cardRadius),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                  border: widget.cardStylePreset == CreditCardStylePreset.glass
                      ? Border.all(color: Colors.white.withAlpha(70))
                      : null,
                ),

                // Overlay with credit card info
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: cardPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: mediaQuery(context, 0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.titleCreditCard,
                              style: (widget.titleTextStyle ?? TextStyle(
                                fontSize: mediaQuery(context, 0.04),
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: widget.cardStylePreset == CreditCardStylePreset.modern
                                    ? 0.5
                                    : 0,
                                fontFamily: widget.fontFamily,
                              )),
                            ),
                            _iconBand(controller),
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
                                package: 'flutter_credit_card_detector',
                              ),
                              width: mediaQuery(context, 0.11),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            height: mediaQuery(context, 0.13),
                            alignment: Alignment.centerLeft,
                            child: Image(
                              image: AssetImage(
                                'assets/contactless.png',
                                package: 'flutter_credit_card_detector',
                              ),
                              color: textColor,
                              width: mediaQuery(context, 0.05),
                            ),
                          ),
                        ],
                      ),

                      //Numero
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.number.isEmpty || controller.number == ''
                              ? 'XXXX XXXX XXXX XXXX'
                              : controller.number,
                          style: (widget.numberTextStyle ?? TextStyle(
                            color: textColor,
                            fontSize: mediaQuery(context, widget.textSizeNumber),
                            letterSpacing: 1.4,
                            fontFamily: widget.fontFamily,
                          )),
                        ),
                      ),

                      //Data e CVV
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  controller.expData.isEmpty
                                      ? ''
                                      : controller.expData,
                                  style: (widget.detailValueTextStyle ?? TextStyle(
                                    fontSize: mediaQuery(context, widget.textSizeMonth),
                                    fontWeight: FontWeight.normal,
                                    color: textColor,
                                    fontFamily: widget.fontFamily,
                                  )),
                                ),
                                Text(
                                  widget.labelTextValidate,
                                  style: (widget.detailLabelTextStyle ?? TextStyle(
                                    fontSize: mediaQuery(context, 0.02),
                                    fontWeight: FontWeight.normal,
                                    color: textColor.withAlpha(220),
                                    fontFamily: widget.fontFamily,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  controller.cvv.isEmpty
                                      ? ''
                                      : controller.cvv,
                                  style: (widget.detailValueTextStyle ?? TextStyle(
                                    fontSize: mediaQuery(context, widget.textSizeCVC),
                                    fontWeight: FontWeight.normal,
                                    color: textColor,
                                    fontFamily: widget.fontFamily,
                                  )),
                                ),
                                Text(
                                  'CVC',
                                  style: (widget.detailLabelTextStyle ?? TextStyle(
                                    fontSize: mediaQuery(context, 0.02),
                                    fontWeight: FontWeight.normal,
                                    color: textColor.withAlpha(220),
                                    fontFamily: widget.fontFamily,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //Nome
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              controller.name.isEmpty
                                  ? ''
                                  : controller.name.toUpperCase(),
                              style: (widget.nameTextStyle ?? TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.normal,
                                fontSize: mediaQuery(
                                  context,
                                  widget.textSizeName,
                                ),
                                fontFamily: widget.fontFamily,
                              )),
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        _creditCardWidget(controller),
      ],
    );
  }
}

class _BrandConfig {
  final String key;
  final CreditCardType type;
  final Color? tint;

  const _BrandConfig(this.key, this.type, [this.tint]);
}
