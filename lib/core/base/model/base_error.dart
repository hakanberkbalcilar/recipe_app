import 'package:recipe_app/core/enum/error_type.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class BaseError {
  final ErrorType type;
  final String message;

  BaseError(this.type, this.message);

  @override
  String toString() => message;

  String toLocalizedString(BuildContext context) => context.localization.somethingWentWrong;
}
