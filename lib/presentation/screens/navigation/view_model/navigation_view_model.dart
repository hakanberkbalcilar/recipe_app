import 'package:recipe_app/core/base/model/base_view_model.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends BaseViewModel {
  void initialize(BuildContext context) {
    if (mounted) return;

    this.context = context;
  }
}
