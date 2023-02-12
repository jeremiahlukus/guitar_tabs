// Dart imports:
import 'dart:io';

// Package imports:
import 'package:diox/diox.dart';

extension DioErrorX on DioError {
  bool get isNoConnectionError {
    return type == DioErrorType.unknown && error is SocketException;
  }
}
