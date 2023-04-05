import 'package:recipe_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.hintText,
      this.backgroundColor,
      this.style,
      this.readOnly = false,
      this.focusNode,
      this.controller,
      this.onChanged,
      this.onTap})
      : super(key: key);

  final String hintText;
  final TextStyle? style;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Function()? onTap;
  final Function(String)? onChanged;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String oldText = '';
  @override
  void initState() {
    widget.controller?.addListener(onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return TextField(
      controller: widget.controller,
      style: widget.style ?? theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground),
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: widget.backgroundColor,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: widget.controller?.text.isEmpty != false
              ? null
              : IconButton(
                  onPressed: () => widget.controller?.text = '',
                  icon: const Icon(Icons.cancel),
                  style: IconButton.styleFrom(foregroundColor: theme.colorScheme.error),
                )),
      onChanged: widget.onChanged,
    );
  }

  void onTextChanged() {
    if ((oldText.isEmpty && widget.controller!.text.isNotEmpty) || (oldText.isNotEmpty && widget.controller!.text.isEmpty)) setState(() {});
    oldText = widget.controller!.text;
  }
}
