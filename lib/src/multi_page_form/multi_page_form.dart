import 'package:flutter/material.dart';
import 'package:schema_form_builder/src/dev_tools/index.dart';

import 'lib_localization.dart';
import 'multi_page_form_controller.dart';
import 'multi_page_form_provider.dart';

LibLocalization mainActionButtonLT = LibLocalization({'en': 'Continue', 'si': 'ඉදිරියට', 'ta': 'தொடரவும்' });

class MultiPageForm extends StatefulWidget {
  final MultiPageFormController controller;
  final String? localization;
  final bool? hideMainActionButton;
  final String? mainActionButtonText;
  final void Function(Map<String, dynamic>)? onSubmit;
  final Function? onPageChanged;
  final Function? onFormChanged;
  final List<Widget> pages;

  const MultiPageForm({
    super.key,
    required this.controller,
    required this.pages,
    this.onSubmit,
    this.onPageChanged,
    this.onFormChanged,
    this.localization,
    this.hideMainActionButton = false,
    this.mainActionButtonText,
  });

  @override
  State<MultiPageForm> createState() => _MultiPageFormState();
}

class _MultiPageFormState extends State<MultiPageForm> {

  void handlePageChanged(int index) {
    widget.controller.onPageChanged(index);
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(index);
    }
  }

  void handleFormChanged() {
    widget.controller.onFormChanged();
    if (widget.onFormChanged != null) {
      widget.onFormChanged!();
    }
  }

  Widget buildMainActionButton() {
    if (widget.hideMainActionButton == true) {
      return const SizedBox();
    }
    return ValueListenableBuilder(
      valueListenable: widget.controller.isMainActionDisabledNotifier,
      builder: (context, value, child) {
        return ElevatedButton(
          onPressed: value ? null : (){
            if(widget.onSubmit != null){
              widget.controller.handleMainAction(widget.onSubmit!);
            } else {
              widget.controller.handleMainAction((data){
                kPrint("Form submitted : $data");
              });
            }
          },
          child: Text(widget.mainActionButtonText ?? mainActionButtonLT.t(widget.localization ?? 'en') ?? 'Continue'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return MultiPageFormProvider(
      controller: widget.controller,
      child: PageView.builder(
        controller: widget.controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: handlePageChanged,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return Form(
            key: widget.controller.formKeys[index],
            onChanged: handleFormChanged,
            child: widget.pages[index],
          );
        },
      ),
    );
  }
}