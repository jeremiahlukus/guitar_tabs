// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

extension DioErrorX on DioException {
  bool get isNoConnectionError {
    return type == DioExceptionType.unknown && error is SocketException;
  }
}
