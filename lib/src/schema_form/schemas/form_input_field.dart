
import 'form_custom.dart';
import 'form_text.dart';
import 'form_validation.dart';
import 'utils.dart';

class FormInputField {
  final String type;
  final String name;
  final FormText label;
  final FormValidation? validation;
  final FormCustom? custom;

  FormInputField({
    required this.type,
    required this.name,
    required this.label,
    this.validation,
    this.custom
  });

  factory FormInputField.fromMap(Map<String, dynamic> fieldMap) {
    return FormInputField(
      type: fieldMap['type'],
      name: fieldMap['name'],
      label: FormText.fromMap(fieldMap['label']),
      validation: getValue<FormValidation>(fieldMap, 'validation', (validation) => FormValidation.fromMap(validation)),
      custom: getValue<FormCustom>(fieldMap, 'custom', (custom) => FormCustom.fromMap(custom)),
    );
  }
}