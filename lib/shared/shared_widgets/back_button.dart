import 'package:flutter/material.dart';

class NavigateBackButton extends StatelessWidget {
  final Function() onPressed;

  const NavigateBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios_new,
      ),
    );
  }
}
