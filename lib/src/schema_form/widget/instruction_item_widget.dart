import 'package:flutter/material.dart';

import '../schemas/form_instruction_content.dart';

class InstructionItemWidget extends StatelessWidget {
  final FormInstructionContent item;
  final String locale;

  const InstructionItemWidget({required this.item, required this.locale, super.key});

  @override
  Widget build(BuildContext context) {
    return _buildItem(context, item, locale);
  }

  Widget _buildItem(BuildContext context, FormInstructionContent item, String locale) {
    final theme = Theme.of(context);

    switch (item.type) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(item.text!.getText(locale), style: theme.textTheme.bodyMedium),
        );
      case 'heading':
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(item.text!.getText(locale), style: theme.textTheme.titleMedium),
        );
      case 'spacer':
        return SizedBox(height: item.space);
      case 'image':
        return Column(
          children: [
            Image.network(item.image!.imageUrl),
            if (item.image!.caption != null) Text(item.image!.caption!.getText(locale)),
          ],
        );
      default:
        return Container();
    }
  }
}