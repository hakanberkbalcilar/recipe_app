import 'package:recipe_app/core/constants/routes.dart';
import 'package:recipe_app/di/provider_impl.dart';
import 'package:recipe_app/presentation/themes/classic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => Consumer(builder: (context, ref, child) {
        final provider = ref.watch(settingsProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: provider.themeMode,
          theme: ClassicTheme.light,
          darkTheme: ClassicTheme.dark,
          locale: provider.language.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: Routes.routerConfig,
        );
      });
}
