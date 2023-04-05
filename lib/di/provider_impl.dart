import 'package:recipe_app/core/providers/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Settings Provider
final settingsProvider = ChangeNotifierProvider((ref) => SettingsProvider());
