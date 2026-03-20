// Supported card types
import 'package:flutter_credit_card_detector/src/utils/enums.dart';

import 'globals.dart';

/// CC prefix patterns as of March 2019
/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
const Map<CreditCardType, Set<List<String>>> cardNumPatterns = {
  CreditCardType.aura: {
    ['50'],
  },
  CreditCardType.visa: {
    ['4'],
  },
  CreditCardType.amex: {
    ['34'],
    ['37'],
  },
  CreditCardType.discover: {
    ['6011'],
    ['64'],
    ['644', '649'],
    ['65'],
  },
  CreditCardType.mastercard: {
    ['51', '55'],
    ['2221', '2229'],
    ['223', '229'],
    ['23', '26'],
    ['270', '271'],
    ['2720'],
  },
  CreditCardType.dinersclub: {
    ['30'],
    ['300', '305'],
    ['36'],
    ['38'],
    ['39'],
  },
  CreditCardType.jcb: {
    ['3506', '3589'],
    ['2131'],
    ['1800'],
  },
  CreditCardType.elo: {
    ['4011'],
    ['401178'],
    ['401179'],
    ['438935'],
    ['457631'],
    ['457632'],
    ['431274'],
    ['451416'],
    ['457393'],
    ['504175'],
    ['506699', '506778'],
    ['509000', '509999'],
    ['627780'],
    ['636297'],
    ['636368'],
    ['650031', '650033'],
    ['650035', '650051'],
    ['650405', '650439'],
    ['650485', '650538'],
    ['650541', '650598'],
    ['650700', '650718'],
    ['650720', '650727'],
    ['650901', '650978'],
    ['651652', '651679'],
    ['655000', '655019'],
    ['655021', '655058'],
    ['6555'],
  },
  CreditCardType.hiper: {
    ['637095'],
    ['637568'],
    ['637599'],
    ['637609'],
    ['637612'],
  },
  CreditCardType.hipercard: {
    ['6062'],
  },
  CreditCardType.rupay: {
    ['6521', '6522'],
  },
  CreditCardType.maestro: {
    ['50'],
    ['56', '69'],
  },
  CreditCardType.unionpay: {
    ['62'],
    ['81'],
  },
  CreditCardType.troy: {
    ['9792'],
  },
  CreditCardType.dankort: {
    ['5019'],
  },
  CreditCardType.uatp: {
    ['1'],
  },
};

/// This function determines the CC type based on the cardPatterns
CreditCardType detectCCType(String ccNumStr) {
  if (ccNumStr.isEmpty) {
    return CreditCardType.unknown;
  }

  // Remove espaços (mantém compat com o comportamento atual)
  final ccDigits = ccNumStr.replaceAll(RegExp(r'\s+\b|\b\s'), '');

  // Para resolver colisões (ex.: "50" pode ser Aura ou Maestro),
  // escolhemos o match mais específico (maior prefixo). Em empate,
  // aplicamos uma prioridade fixa.
  const priority = <CreditCardType, int>{
    CreditCardType.maestro: 110,
    CreditCardType.aura: 100,
    CreditCardType.visa: 90,
    CreditCardType.mastercard: 90,
    CreditCardType.amex: 90,
    CreditCardType.elo: 90,
    CreditCardType.hipercard: 80,
    CreditCardType.hiper: 80,
    CreditCardType.dinersclub: 80,
    CreditCardType.discover: 80,
    CreditCardType.jcb: 80,
    CreditCardType.rupay: 70,
    CreditCardType.unionpay: 60,
    CreditCardType.troy: 60,
    CreditCardType.dankort: 60,
    CreditCardType.uatp: 50,
  };

  CreditCardType bestType = CreditCardType.unknown;
  int bestPrefixLen = 0;
  int bestPriority = -1;

  bool isAllowed(CreditCardType type) {
    final name = type.toString().replaceAll('CreditCardType.', '');
    return listBand.contains(name);
  }

  for (final entry in cardNumPatterns.entries) {
    final type = entry.key;
    if (!isAllowed(type)) continue;

    for (final patternRange in entry.value) {
      final rangeLen = patternRange[0].length;
      final ccPrefix = (rangeLen < ccDigits.length) ? ccDigits.substring(0, rangeLen) : ccDigits;

      bool matched = false;
      if (patternRange.length > 1) {
        final ccPrefixAsInt = int.tryParse(ccPrefix);
        final startAsInt = int.tryParse(patternRange[0]);
        final endAsInt = int.tryParse(patternRange[1]);
        if (ccPrefixAsInt != null && startAsInt != null && endAsInt != null) {
          matched = ccPrefixAsInt >= startAsInt && ccPrefixAsInt <= endAsInt;
        }
      } else {
        matched = ccPrefix == patternRange[0];
      }

      if (!matched) continue;

      final p = priority[type] ?? 0;
      final isBetter = (rangeLen > bestPrefixLen) || (rangeLen == bestPrefixLen && p > bestPriority);
      if (isBetter) {
        bestType = type;
        bestPrefixLen = rangeLen;
        bestPriority = p;
      }
    }
  }

  return bestType;
}
