// Supported card types
import 'globals.dart';

enum CreditCardType {
  aura,
  visa,
  amex,
  discover,
  mastercard,
  dinersclub,
  jcb,
  elo,
  hiper,
  hipercard,
  rupay,
  unknown,
}

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
  }
};

/// This function determines the CC type based on the cardPatterns
CreditCardType detectCCType(String ccNumStr) {
  CreditCardType cardType = CreditCardType.unknown;

  if (ccNumStr.isEmpty) {
    return cardType;
  }

  //TODO error checking for strings with non-numerical chars

  cardNumPatterns.forEach(
    (CreditCardType type, Set<List<String>> patterns) {
      for (List<String> patternRange in patterns) {
        // Remove any spaces
        String ccPatternStr = ccNumStr.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        int rangeLen = patternRange[0].length;
        // Trim the CC number str to match the pattern prefix length
        if (rangeLen < ccNumStr.length) {
          ccPatternStr = ccPatternStr.substring(0, rangeLen);
        }

        if (patternRange.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // CC num is in the pattern range.
          // Because Strings don't have '>=' type operators
          int ccPrefixAsInt = int.parse(ccPatternStr);
          int startPatternPrefixAsInt = int.parse(patternRange[0]);
          int endPatternPrefixAsInt = int.parse(patternRange[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt &&
              ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            cardType = type;
            break;
          }
        } else {
          // Just compare the single pattern prefix with the CC prefix
          if (ccPatternStr == patternRange[0]) {
            // Found a match
            cardType = type;
            break;
          }
        }
      }
    },
  );

  var listCCTypeBand = cardType.toString().replaceAll('CreditCardType.', '');
  if (listBand.contains(listCCTypeBand)) {
    cardType = cardType;
  } else {
    cardType = CreditCardType.unknown;
  }

  return cardType;
}
