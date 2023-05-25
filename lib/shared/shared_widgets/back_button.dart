import 'package:flutter/material.dart';

class NavigateBackButton extends StatelessWidget {
  final Function() onPressed;
  final String semanticLabel;

  const NavigateBackButton({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios_new,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
