import 'dart:async';
import 'dart:io';

String apiError(Exception error, String code) {
  String response =
      'Se produjo un error, por favor intentalo nuevamente (cod: ${code}5)';

  if (error is HttpException) {
    response =
        'Se produjo un error, por favor intentalo nuevamente (cod: ${code}1)';
  } else if (error is FormatException) {
    response =
        'Se produjo un error, por favor intentalo nuevamente (cod: ${code}2)';
  } else if (error is SocketException) {
    response =
        'Se produjo un error, por favor intentalo nuevamente (cod: ${code}3)';
  } else if (error is TimeoutException) {
    response =
        'Se produjo un error, por favor intentalo nuevamente (cod: ${code}4)';
  }

  return response;
}
