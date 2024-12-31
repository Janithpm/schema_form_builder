import 'package:flutter/material.dart';

import 'schema_form_controller.dart';
import 'schema_form_options.dart';
import 'widget/page_view_builder.dart';

class SchemaForm extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic>? reasonsRen;
  final Locale locale;
  final Function(Map<String, dynamic>) onSubmit;
  final Function(BuildContext context, Widget content, SchemaFormOptions options) builder;

  const SchemaForm.builder({
    super.key,
    required this.schema,
    required this.locale,
    required this.builder,
    required this.onSubmit,
    this.reasonsRen,
  });

  @override
  State<SchemaForm> createState() => _SchemaFormState();
}

class _SchemaFormState extends State<SchemaForm> {
  late final SchemaFormController controller;

  @override
  void initState() {
    super.initState();
    controller = SchemaFormController();
    controller.initialize(widget.schema);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final firstPage = controller.formSchema.pages.first;
      controller.handlePageInstructions(context, firstPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale.languageCode;
    final options = controller.createSchemaFormOptions(locale, context, widget.onSubmit);

    return widget.builder(
      context,
      Form(
        key: controller.formKey,
        child: PageViewBuilder(
          pageController: controller.pageController,
          locale: locale,
          //Todo: this reasons handling part need to be refactored
          reasonsRen: widget.reasonsRen,
          onPageChanged: (index) => setState(() => controller.onPageChanged(context, index)),
          onNext: () => controller.next(context, widget.onSubmit),
          formSchema: controller.formSchema,
          schemaFormData: controller.schemaFormData,
        ),
      ),
      options,
    );
  }
}