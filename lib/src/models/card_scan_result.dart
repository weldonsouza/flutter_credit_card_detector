import 'package:flutter/foundation.dart';

/// Dados opcionais retornados pelo app após escanear o cartão (câmera/OCR).
/// O [CreditCardWidget] aplica apenas os campos não nulos e não vazios.
@immutable
class CardScanResult {
  const CardScanResult({
    this.cardNumber,
    this.holderName,
    this.expiryMmYy,
  });

  /// Número do cartão; dígitos são preservados, demais caracteres removidos.
  final String? cardNumber;

  /// Nome impresso no cartão.
  final String? holderName;

  /// Validade em MM/YY ou MM/YYYY (ou só dígitos MMyy).
  final String? expiryMmYy;
}
