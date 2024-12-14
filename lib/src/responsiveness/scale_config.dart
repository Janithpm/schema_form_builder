class ScaleConfig {
  final double scaleFactorWidth;
  final double scaleFactorHeight;

  ScaleConfig({required double screenWidth, required double screenHeight, required double designWidth, required double designHeight})
      : scaleFactorWidth = screenWidth / designWidth,
        scaleFactorHeight = screenHeight / designHeight;

  double getScaledWidth(double width) {
    return double.parse((width * scaleFactorWidth).toStringAsFixed(3));
  }

  double getScaledHeight(double height) {
    return double.parse((height * scaleFactorHeight).toStringAsFixed(3));
  }
}