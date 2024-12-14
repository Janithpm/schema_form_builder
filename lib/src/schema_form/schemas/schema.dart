import 'form_summary.dart';
import 'form_page.dart';
import 'form_agreement.dart';
import 'form_action.dart';
import 'utils.dart';

class FormSchema {
  final bool? localization;
  final FormSummary? summary;
  final List<FormPage> pages;
  final List<FormAgreement>? agreements;
  final List<FormAction>? actions;

  FormSchema({
    this.localization,
    this.summary,
    required this.pages,
    this.agreements,
    this.actions,
  });

  factory FormSchema.fromMap(Map<String, dynamic> schemaMap) {
    return FormSchema(
      localization: getValue<bool>(schemaMap, 'localization'),
      summary: getValue<FormSummary>(schemaMap, 'summary', (summary) => FormSummary.fromMap(summary)),
      pages: (schemaMap['pages'] as List).map((page) => FormPage.fromMap(page)).toList(),
      agreements: getValue<List<FormAgreement>>(schemaMap, 'agreements', (agreements) => (agreements as List).map((agreement) => FormAgreement.fromMap(agreement)).toList()),
      actions: getValue<List<FormAction>>(schemaMap, 'actions', (actions) => (actions as List).map((action) => FormAction.fromMap(action)).toList()),
    );
  }
}