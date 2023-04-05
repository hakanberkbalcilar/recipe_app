import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ButtonX extends StatelessWidget {
  const ButtonX(
      {Key? key,
      this.leading,
      this.trailing,
      required this.text,
      this.textAlign = TextAlign.center,
      this.loading = false,
      this.backgroundColor,
      this.foregroundColor,
      this.minWidth = 70,
      this.maxWidth = double.maxFinite,
      this.size = ButtonSize.large,
      this.textPadding = 5,
      this.onTap})
      : super(key: key);

  final Widget? leading;
  final Widget? trailing;
  final String text;
  final bool loading;
  final TextAlign textAlign;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double minWidth;
  final double maxWidth;
  final double textPadding;
  final ButtonSize size;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = this.foregroundColor ?? context.theme.elevatedButtonTheme.style?.foregroundColor?.resolve({});
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(size.padding),
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              minimumSize: Size(minWidth, size.height),
              fixedSize: Size(double.maxFinite, size.height),
              maximumSize: Size(maxWidth, size.height),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap)
          .merge(ButtonStyle(elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) => 0.0))),
      onPressed: onTap == null
          ? null
          : () {
              if (loading) return;
              onTap?.call();
            },
      child: loading && leading == null && trailing == null
          ? FittedBox(
              child: CircularProgressIndicator(
                color: foregroundColor,
                strokeWidth: 2,
              ),
            )
          : _content(context),
    );
  }

  _content(BuildContext context) {
    final theme = context.theme;
    final backgroundColor = this.backgroundColor ?? theme.elevatedButtonTheme.style?.backgroundColor?.resolve({});
    final foregroundColor = this.foregroundColor ?? theme.elevatedButtonTheme.style?.foregroundColor?.resolve({});
    final leadingSize = size.height - (size.padding * 2);
    return IconTheme(
      data: theme.iconTheme.copyWith(color: backgroundColor, size: 18),
      child: Row(
        children: [
          if (leading != null)
            DefaultTextStyle(
              style: TextStyle(color: backgroundColor),
              child: Container(
                height: leadingSize,
                width: leadingSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: foregroundColor,
                ),
                padding: EdgeInsets.all(size.padding),
                child: loading ? CircularProgressIndicator(strokeWidth: 2, color: backgroundColor) : leading,
              ),
            ),
          Expanded(child: _text()),
          if (trailing != null)
            DefaultTextStyle(
              style: TextStyle(color: backgroundColor),
              child: Container(
                height: leadingSize,
                width: leadingSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: foregroundColor,
                ),
                padding: EdgeInsets.all(size.padding),
                child: loading ? CircularProgressIndicator(strokeWidth: 2, color: backgroundColor) : trailing,
              ),
            ),
        ],
      ),
    );
  }

  _text() => Padding(
        padding: EdgeInsets.symmetric(horizontal: textPadding),
        child: Text(
          text,
          textAlign: textAlign,
          maxLines: 1,
          style: TextStyle(
            fontSize: size.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}

enum ButtonSize {
  small(26, 6, 10),
  medium(40, 6, 13),
  large(50, 8, 16),
  free(double.infinity, 8, 16);

  final double height;
  final double padding;
  final double fontSize;

  const ButtonSize(this.height, this.padding, this.fontSize);
}
