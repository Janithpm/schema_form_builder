import 'package:flutter/material.dart';
import '../schema_form_data.dart';
import '../schemas/form_page.dart';
import 'field_widget.dart';

class PageWidget extends StatelessWidget {
  final FormPage page;
  final String locale;
  final VoidCallback onNext;
  final SchemaFormData schemaFormData;
  final   Map<String, dynamic>? reasonsRen;

  const PageWidget({
    super.key,
    required this.page,
    required this.locale,
    required this.onNext,
    required this.schemaFormData,
    this.reasonsRen
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...page.fields!.map((field) {
                          return FieldWidget(field: field, locale: locale, getValue: schemaFormData.getValue, setValue: schemaFormData.setValue, reasonsRen: getReasons(reasonsRen, field.name, locale));
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onNext,
                        child: const Text('Continue'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}


dynamic getReasons(Map<String, dynamic>? reasons, String name, String locale) {
  if (reasons == null || reasons[name] == null) {
    return [];
  }

  return reasons[name].map((r) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text('. ${r[locale]}', style: const TextStyle(color: Colors.redAccent, fontSize: 12),),
  ));
}