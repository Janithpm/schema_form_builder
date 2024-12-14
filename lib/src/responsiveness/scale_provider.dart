import 'package:flutter/material.dart';
import 'scale_config.dart';

class ScaleProvider extends InheritedWidget {
  final ScaleConfig scaleConfig;

  const ScaleProvider({
    super.key,
    required this.scaleConfig,
    required super.child,
  });

  static ScaleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScaleProvider>();
  }

  @override
  bool updateShouldNotify(ScaleProvider oldWidget) {
    return oldWidget.scaleConfig != scaleConfig;
  }
}