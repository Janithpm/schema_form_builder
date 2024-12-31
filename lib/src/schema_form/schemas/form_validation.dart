class FormValidation {
  final bool? required;
  final int? minLength;

  FormValidation({this.required, this.minLength});

  factory FormValidation.fromMap(Map<String, dynamic> validationMap) {
    return FormValidation(
      required: validationMap['required'],
      minLength: validationMap['minLength'],
    );
  }

  // Method to validate a given value
  bool validate(String value) {
    if (required == true && value.isEmpty) return false;
    if (minLength != null && value.length < minLength!) return false;
    return true;
  }
}