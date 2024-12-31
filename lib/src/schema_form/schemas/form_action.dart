import 'form_text.dart';

class FormAction {
  final FormText label;
  final String type;

  FormAction({
    required this.label,
    required this.type,
  });

  factory FormAction.fromMap(Map<String, dynamic> actionMap) {
    return FormAction(
      label: FormText.fromMap(actionMap['label']),
      type: actionMap['type'],
    );
  }
}