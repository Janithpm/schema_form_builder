import 'package:flutter/material.dart';

import '../schema_form_data.dart';
import '../schemas/schema.dart';
import 'page_widget.dart';

class PageViewBuilder extends StatelessWidget {
  final PageController pageController;
  final String locale;
  final Function(int) onPageChanged;
  final Function() onNext;
  final FormSchema formSchema;
  final SchemaFormData schemaFormData;
  final Map<String, dynamic>? reasonsRen;

  const PageViewBuilder({
    super.key,
    required this.pageController,
    required this.locale,
    required this.onPageChanged,
    required this.onNext,
    required this.formSchema,
    required this.schemaFormData,
    this.reasonsRen
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: formSchema.pages.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return PageWidget(
          page: formSchema.pages[index],
          onNext: onNext,
          locale: locale,
            schemaFormData: schemaFormData,
            reasonsRen:reasonsRen
        );
      },
    );
  }
}
