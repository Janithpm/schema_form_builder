import 'form_action.dart';

class FormActions {
  final FormAction primary;
  final FormAction secondary;

  FormActions({
    required this.primary,
    required this.secondary,
  });

  // Factory constructor to create Actions from a Map
  factory FormActions.fromMap(Map<String, dynamic> actionsMap) {
    return FormActions(
      primary: FormAction.fromMap(actionsMap['primary']),
      secondary: FormAction.fromMap(actionsMap['secondary']),
    );
  }
}