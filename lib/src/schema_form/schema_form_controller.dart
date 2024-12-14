import 'package:flutter/material.dart';

import '../dev_tools/index.dart';
import 'schema_form_options.dart';
import 'schema_form_data.dart';
import 'schemas/form_instructions.dart';
import 'schemas/form_page.dart';
import 'schemas/schema.dart';
import 'widget/instruction_sheet_widget.dart';

class SchemaFormController {
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Duration instructionDelay = const Duration(milliseconds: 200);
  final Duration transitionDuration = const Duration(milliseconds: 300);

  late FormSchema formSchema;
  late SchemaFormData schemaFormData;
  int currentPage = 0;
  final Set<String> shownInstructionsPages = {};

  void initialize(Map<String, dynamic> schema) {
    formSchema = FormSchema.fromMap(schema);
    schemaFormData = SchemaFormData(formSchema);
  }

  Future<void> handlePageInstructions(BuildContext context, FormPage page) async {
    if (page.instructions == null || !page.instructions!.displayOnLoad! || shownInstructionsPages.contains(page.name)) {
      return;
    }
    shownInstructionsPages.add(page.name);

    await Future.delayed(instructionDelay);
    _showInstructions(context, page.instructions!);
  }

  void incrementPage() {
    currentPage++;
  }

  void decrementPage() {
    currentPage--;
  }

  void next(BuildContext context, Function(Map<String, dynamic>) onSubmit) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (currentPage < formSchema.pages.length - 1) {
        incrementPage();
        pageController.nextPage(
          duration: transitionDuration,
          curve: Curves.easeInOut,
        );
      } else {
        onSubmit(schemaFormData.getFormData());
      }
    } else {
      kPrint('Form is not valid');
    }
  }

  void previous() {
    if (currentPage > 0) {
      formKey.currentState!.save();
      decrementPage();
      pageController.previousPage(
        duration: transitionDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(BuildContext context, int index) {
    final currentPageObject = formSchema.pages[index];
    handlePageInstructions(context, currentPageObject);
  }

  SchemaFormOptions createSchemaFormOptions(String locale, BuildContext context, Function(Map<String, dynamic>) onSubmit) {
    return SchemaFormOptions(
      title: formSchema.pages[currentPage].title.getText(locale),
      next: () => next(context, onSubmit),
      previous: previous,
      currentPage: currentPage,
      isLastPage: currentPage == formSchema.pages.length - 1,
    );
  }

  void _showInstructions(BuildContext context, FormInstructions instructions) {
    final locale = Localizations.localeOf(context).languageCode;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: instructions.isDraggable ?? true,
      barrierColor: Colors.black.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return InstructionSheetWidget(
          instructions: instructions,
          locale: locale,
        );
      },
    );
  }
}