class CardUtils {
  static String validateCardHolderName(String value) {
    if (value.isEmpty) {
      return 'required field';
    }
    return null;
  }

  static String validateCVV(String value) {
    if (value.isEmpty) {
      return 'required field';
    }

    if (value.length < 3 || value.length > 4) {
      return 'Invalid CVV';
    }
    return null;
  }

  static String validateDate(String value) {
    if (value.isEmpty) {
      return 'required field';
    }

    int year;
    int month;

    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }
    if ((month < 1) || (month > 12)) {
      return 'Expired month';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) ||
        (fourDigitsYear > DateTime.now().add(Duration(days: 365 * 25)).year)) {
      return 'Expired year!!!';
    }

    if (!hasDateExpired(month, year)) {
      return 'Card is expired';
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  /// Luhn Algorithm is used to validate card
  /// https://en.wikipedia.org/wiki/Luhn_algorithm
  static String validateCardNumber(String input) {
    if (input.isEmpty) {
      return 'Card number is required field';
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return 'Invalid card number';
    }
    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      int digit = int.parse(input[length - i - 1]);
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return 'Invalid card number';
  }
}
