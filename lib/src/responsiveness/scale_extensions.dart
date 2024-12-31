import 'package:flutter/material.dart';
import 'scale_provider.dart';

extension ScaleExtensions on BuildContext {
  double scaledWidth(double width) {
    final provider = ScaleProvider.of(this);
    if (provider == null) throw Exception("ScaleProvider not found in context");
    return provider.scaleConfig.getScaledWidth(width);
  }

  double scaledHeight(double height) {
    final provider = ScaleProvider.of(this);
    if (provider == null) throw Exception("ScaleProvider not found in context");
    return provider.scaleConfig.getScaledHeight(height);
  }
}