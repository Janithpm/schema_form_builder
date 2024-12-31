import 'package:flutter/material.dart';

import '../schemas/form_instructions.dart';
import 'instruction_item_widget.dart';

class InstructionSheetWidget extends StatelessWidget {
  final FormInstructions instructions;
  final String locale;
  const InstructionSheetWidget({super.key, required this.instructions, required this.locale});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...instructions.content.map((item) => InstructionItemWidget(item: item, locale: locale)),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(instructions.action!.getText(locale)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
