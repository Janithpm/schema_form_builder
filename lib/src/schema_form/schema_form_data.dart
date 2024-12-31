import 'schemas/schema.dart';

class SchemaFormData {
  final Map<String, dynamic> _formData = {};

  SchemaFormData(FormSchema schema) {
    for (final page in schema.pages) {
      for (final field in page.fields!) {
        _formData[field.name] = null;
      }
    }
  }

  dynamic getValue(String key) => _formData[key];

  void setValue(String key, dynamic value) {
    _formData[key] = value;
  }

  //Todo: Remove if not used
  bool validate(FormSchema schema) {
    for (final page in schema.pages) {
      for (final field in page.fields!) {
        final value = _formData[field.name];
        if (field.validation?.required == true && (value == null || value.toString().isEmpty)) {
          return false;
        }
        if (field.validation?.minLength != null && value != null && value.toString().length < field.validation!.minLength!) {
          return false;
        }
      }
    }
    return true;
  }

  Map<String, dynamic> getFormData() => _formData;

  void clear() {
    _formData.clear();
  }
}