import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;
  BuildContext get context => _context!;
  set context(BuildContext context) => _context = context;

  bool get mounted => _context?.mounted ?? false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  changeLoading(bool value, [bool notify = true]) {
    _isLoading = value;
    if (notify) notifyListeners();
  }
}
