import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/dimens.dart';
import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:recipe_app/core/extensions/num_extension.dart';

class InstructionListTile extends StatelessWidget {
  const InstructionListTile(this.index, this.instruction, {super.key});

  final int index;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      borderRadius: Dimens.radiusTile.toBorderRadius(),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingTile),
        child: Row(
          children: [
            Expanded(
              child: Text(
                instruction,
                style: theme.textTheme.titleSmall,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
