import 'package:flutter/material.dart';
import 'multi_page_form_controller.dart';

class MultiPageFormProvider extends InheritedWidget {
  final MultiPageFormController controller;

  const MultiPageFormProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static MultiPageFormController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<MultiPageFormProvider>();
    return provider!.controller;
  }

  @override
  bool updateShouldNotify(MultiPageFormProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}