import 'package:flutter/material.dart';

/// Estado e callbacks para montar o botão de escaneamento ao lado do número.
@immutable
class CardScanButtonData {
  const CardScanButtonData({
    required this.enabled,
    required this.loading,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    this.tooltip,
  });

  /// `false` quando [onCardScan] não foi informado.
  final bool enabled;

  /// `true` enquanto o [Future] de [CreditCardWidget.onCardScan] está em execução.
  final bool loading;

  /// Dispara o fluxo de escaneamento; `null` quando desabilitado.
  final VoidCallback? onPressed;

  /// Valores de [CreditCardWidget.cardScanIcon] e [CreditCardWidget.cardScanIconColor] (ou padrões).
  final IconData icon;
  final Color iconColor;

  /// [CreditCardWidget.cardScanTooltip], se houver.
  final String? tooltip;
}

/// Permite substituir o layout padrão (quadrado com [Material]/[InkWell]) do botão de escaneamento.
typedef CardScanButtonBuilder = Widget Function(
  BuildContext context,
  CardScanButtonData data,
);
