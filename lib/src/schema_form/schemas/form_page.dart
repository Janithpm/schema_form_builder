
import 'form_instructions.dart';
import 'form_text.dart';
import 'form_input_field.dart';
import 'utils.dart';

class FormPage {
  final String name;
  final FormText title;
  final FormText? description;
  final bool? editable;
  final List<FormInputField>? fields;
  final FormInstructions? instructions;

  FormPage({
    required this.name,
    required this.title,
    this.description,
    this.editable,
    this.fields,
    this.instructions,
  });

  factory FormPage.fromMap(Map<String, dynamic> pageMap) {
    return FormPage(
      name: pageMap['name'],
      title: FormText.fromMap(pageMap['title']),
      description: getValue<FormText>(pageMap, 'description', (description) => FormText.fromMap(description)),
      editable: getValue<bool>(pageMap, 'editable') ?? false,
      fields: getValue<List<FormInputField>>(pageMap, 'fields', (fields) => (fields as List).map((field) => FormInputField.fromMap(field)).toList()) ?? [],
      instructions: getValue<FormInstructions>(pageMap, 'instructions', (instruction) => FormInstructions.fromMap(instruction)),
    );
  }
}