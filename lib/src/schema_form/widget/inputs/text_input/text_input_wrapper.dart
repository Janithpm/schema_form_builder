import 'package:flutter/material.dart';

class TextInputWrapper extends StatelessWidget {
  final String? label;
  final double? height;
  final Widget child;

  const TextInputWrapper({super.key, this.label, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(label != null) Text(
          label!,
          style: const TextStyle(fontSize: 16),
        ),
        if(label != null) SizedBox(height: height!),
        child,
      ],
    );
  }
}
