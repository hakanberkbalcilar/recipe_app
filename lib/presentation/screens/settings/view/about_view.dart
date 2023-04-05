import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recipe_app/core/base/state/consumer_state_x.dart';
import 'package:recipe_app/core/constants/dimens.dart';

class AboutView extends ConsumerStatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends ConsumerStateX<AboutView> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) => setState(() => packageInfo = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(localization.about),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.paddingPageHorizontal),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: mediaQuery.size.width * 2,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.background,
                  radius: mediaQuery.size.width * .25,
                  child: Icon(
                    Icons.soup_kitchen_rounded,
                    color: theme.colorScheme.primary,
                    size: mediaQuery.size.width * .25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimens.paddingTileBetween),
            Text(
              packageInfo?.appName ?? '',
              style: theme.textTheme.titleLarge,
            ),
            Text(
              packageInfo?.version ?? '',
              style: theme.textTheme.labelSmall,
            )
          ],
        ),
      ),
    );
  }
}
