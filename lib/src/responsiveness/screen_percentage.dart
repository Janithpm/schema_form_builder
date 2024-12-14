import 'package:flutter/material.dart';

double hp(BuildContext context, double percentage) {
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight * percentage;
}

double wp(BuildContext context, double percentage) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * percentage;
}

double sp(BuildContext context, double fontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * fontSize;
}

double hpProportionate(BuildContext context, double designHeight, double height) {
  return hp(context, height / designHeight);
}

double wpProportionate(BuildContext context, double designWidth, double width) {
  return wp(context, width / designWidth);
}

double spProportionate(BuildContext context, double designWidth, double fontSize) {
  return sp(context, fontSize / designWidth);
}