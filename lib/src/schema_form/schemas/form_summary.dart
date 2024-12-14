import 'form_text.dart';

class FormSummary {
  final bool display;
  final FormText title;

  FormSummary({
    required this.display,
    required this.title,
  });

  factory FormSummary.fromMap(Map<String, dynamic> summaryMap) {
    return FormSummary(
      display: summaryMap['display'],
      title: FormText.fromMap(summaryMap['title']),
    );
  }
}