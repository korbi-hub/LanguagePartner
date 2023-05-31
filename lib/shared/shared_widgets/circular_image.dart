
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String path;
  final double size;

  const CircularImage({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90.0),
        child: Image.asset(
          path,
          height: size,
          width: size,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}