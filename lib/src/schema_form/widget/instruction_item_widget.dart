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
    final spacing = theme.extension<TSpacing>()!;

    switch (item.type) {
      case 'text':
        return Padding(
          padding: EdgeInsets.only(bottom: spacing.sm),
          child: Text(item.text!.getText(locale), style: theme.textTheme.bodyMedium),
        );
      case 'heading':
        return Padding(
          padding: EdgeInsets.only(bottom: spacing.normal),
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
        // Todo: need to implement
      // case 'numberedList':
      //   return Column(
      //     children: item.numberedList!.map((item) => Text(item.getText(locale))).toList(),
      //   );
      default:
        return Container();
    }
  }
}