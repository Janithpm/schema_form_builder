import 'package:flutter/material.dart';
import 'package:traveller_common/src/theme/index.dart';

import '../../../buttons/t_elevated_button.dart';
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
    final theme = Theme.of(context);
    final textStyle = theme.extension<TTextStyle>()!;
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
                  if (page.description != null) Text(page.description!.getText(locale)),
                  Text("Notice!", style: textStyle.titleExtraSmall2),
                  const SizedBox(height: 16,),
                  Text(
                    "We are in the process of reviewing your information and have encountered some issues. To proceed, we kindly request you to  resubmit the following  documents. Please upload them at your earliest convenience.",
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...page.fields!.map((field) {

                          return FieldWidget(field: field, locale: locale, getValue: schemaFormData.getValue, setValue: schemaFormData.setValue, reasonsRen: getReasons(reasonsRen, field.name, locale));


                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15,),
                                    ...getReasons(reasonsRen, field.name, locale),
                                    const SizedBox(height: 15,),
                                    FieldWidget(field: field, locale: locale, getValue: schemaFormData.getValue, setValue: schemaFormData.setValue),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TElevatedButton(
                        onPressed: onNext,
                        child: Text('Continue'),
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