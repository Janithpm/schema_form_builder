import 'form_instruction_content.dart';
import 'form_text.dart';
import 'utils.dart';

class FormInstructions {
  final bool? isDraggable;
  final bool? displayOnLoad;
  final FormText? title;
  final List<FormInstructionContent> content;
  final FormText? action;

  FormInstructions({
    this.isDraggable,
    this.displayOnLoad,
    this.title,
    required this.content,
    this.action,
  });

  factory FormInstructions.fromMap(Map<String, dynamic> instructionsMap) {
    return FormInstructions(
      isDraggable: getValue<bool>(instructionsMap, 'isDraggable') ?? false,
      displayOnLoad: getValue<bool>(instructionsMap, 'displayOnLoad') ?? false,
      title: getValue<FormText>(instructionsMap, 'title', (title) => FormText.fromMap(title)),
      content: getValue<List<FormInstructionContent>>(instructionsMap, 'content', (content) => (content as List).map((item) => FormInstructionContent.fromMap(item)).toList()) ?? [],
      action: getValue<FormText>(instructionsMap, 'action', (action) => FormText.fromMap(action)),
    );
  }
}