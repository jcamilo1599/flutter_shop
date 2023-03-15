extension StringExt on String {
  String get thousand {
    // Obtiene el decimal del valor
    final List<String> splitDecimal = split('.');
    final String decimal =
        (splitDecimal.length > 1) ? ',${splitDecimal[1]}' : '';

    // En caso de ser un valor negativo
    final List<String> splitNegative = split('-');
    final bool isNegative = splitNegative[0] == '';
    final String denial = isNegative ? '-' : '';

    // Obtiene el valor
    final String value =
        isNegative ? splitDecimal[0].substring(1) : splitDecimal[0];

    String priceInText = '';
    int counter = 0;

    for (int number = value.length - 1; number >= 0; number--) {
      final String key = value[number];
      counter++;

      if ((counter % 3) != 0 && number != 0 || number == 0) {
        priceInText = '$key$priceInText';
      } else {
        priceInText = '.$key$priceInText';
      }
    }

    return '$denial$priceInText$decimal';
  }
}
