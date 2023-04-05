import 'dart:io';
import 'package:dio/dio.dart';

extension ResponseExtension on Response? {
  bool get isSuccess => this?.statusCode == HttpStatus.ok;
  String get errorMessage {
    final res = this;
    if (res == null) return '';
    return res.data is String ? res.data : res.statusMessage;
  }
}
