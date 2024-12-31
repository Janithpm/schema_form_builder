import 'form_action.dart';

class FormActions {
  final FormAction primary;
  final FormAction secondary;

  FormActions({
    required this.primary,
    required this.secondary,
  });

  factory FormActions.fromMap(Map<String, dynamic> actionsMap) {
    return FormActions(
      primary: FormAction.fromMap(actionsMap['primary']),
      secondary: FormAction.fromMap(actionsMap['secondary']),
    );
  }
}