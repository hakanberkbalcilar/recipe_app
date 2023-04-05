import 'package:recipe_app/core/base/model/base_error.dart';
import 'package:recipe_app/core/enum/error_type.dart';
import 'package:recipe_app/core/extensions/response_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

extension DioErrorExtension on DioError {
  Either<BaseError, T> toEitherBaseError<T>() => left<BaseError, T>(BaseError(ErrorType.fromStatusCode(response?.statusCode), response.errorMessage));
}
