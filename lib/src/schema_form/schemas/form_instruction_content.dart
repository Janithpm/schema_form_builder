import 'image_content.dart';
import 'form_text.dart';
import 'utils.dart';

class FormInstructionContent {
  final String? type;
  final FormText? text;
  final double? space;
  final ImageContent? image;
  // Todo: need to implement
  // final List<FormText>? numberedList;

  FormInstructionContent({required this.type, this.text, this.space, this.image});

  static FormInstructionContent fromMap(Map<String, dynamic> map) {
    return FormInstructionContent(
      type: map['type'],
      text: getValue<FormText>(map, 'text', (text) => FormText.fromMap(text)),
      space: getValue<double>(map, 'space'),
      image: getValue<ImageContent>(map, 'image', (image) => ImageContent.fromMap(image)),
      // numberedList: getValue<List<FormText>>(map, 'items', (items) => items.map((item) => FormText.fromMap(item)).toList()) ?? [],
    );
  }
}