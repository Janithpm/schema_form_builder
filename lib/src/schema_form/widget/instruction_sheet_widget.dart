import 'package:flutter/material.dart';
import 'package:traveller_common/src/responsiveness/scale_extensions.dart';

import '../schemas/form_instructions.dart';
import 'instruction_item_widget.dart';

class InstructionSheetWidget extends StatelessWidget {
  final FormInstructions instructions;
  final String locale;
  const InstructionSheetWidget({super.key, required this.instructions, required this.locale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(spacing.md),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...instructions.content.map((item) => InstructionItemWidget(item: item, locale: locale)),
            SizedBox(height: context.scaledHeight(spacing.md)),
            Center(
              child: TElevatedButton(
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
