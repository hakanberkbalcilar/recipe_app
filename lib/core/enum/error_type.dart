import 'package:dartx/dartx.dart';

enum ErrorType {
  notFound(404),
  conflict(409),
  other(-1);

  const ErrorType(this.statusCode);
  final int statusCode;

  static ErrorType fromStatusCode(int? statusCode) => ErrorType.values.firstOrNullWhere((x) => x.statusCode == statusCode) ?? ErrorType.other;
}
