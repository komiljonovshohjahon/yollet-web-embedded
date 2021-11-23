import 'package:intl/intl.dart';

const _currency2Locale = {'KRW': 'ko', 'USD': 'en', 'KZT': 'kk', 'RUB': 'ru'};

class CurrencyFormatter {
  static NumberFormat simpleCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR");
  static NumberFormat simpleCurrencyDecimal =
      NumberFormat.simpleCurrency(locale: "ko_KR");

  static NumberFormat noSymbolCurrency =
      NumberFormat.currency(locale: "ko_KR", symbol: '');

  static void set(String? currency) {
    if (_currency2Locale.containsKey(currency)) {
      if (_currency2Locale[currency] == 'ko') {
        simpleCurrency = NumberFormat('#,##0\u00A0원', 'ko');
        simpleCurrency.minimumFractionDigits = 0;
        simpleCurrencyDecimal = NumberFormat('#,##0\u00A0원', 'ko');
        simpleCurrencyDecimal.minimumFractionDigits = 0;
        noSymbolCurrency = NumberFormat.currency(locale: 'ko', symbol: '');
      } else {
        simpleCurrency =
            NumberFormat.simpleCurrency(locale: _currency2Locale[currency!]);
        simpleCurrencyDecimal =
            NumberFormat.simpleCurrency(locale: _currency2Locale[currency]);
        simpleCurrencyDecimal.minimumFractionDigits = 0;
        noSymbolCurrency = NumberFormat.currency(
            locale: _currency2Locale[currency], symbol: '');
      }
    }
  }
}

class DecimalFormatter {
  static NumberFormat simpleDecimal = NumberFormat.decimalPattern("kk_KZ");

  static void set(String? currency) {
    if (_currency2Locale.containsKey(currency)) {
      simpleDecimal = NumberFormat.decimalPattern(_currency2Locale[currency!]);
    }
  }
}
