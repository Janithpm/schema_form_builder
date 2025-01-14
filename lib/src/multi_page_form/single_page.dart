import 'package:flutter/material.dart';

class SinglePage extends StatelessWidget {
  final VoidCallback? onNext;
  final Widget pageContent;
  final Map<String, dynamic>? reasonsRen;
  final String nextButtonText;

  const SinglePage({
    super.key,
    this.onNext,
    required this.pageContent,
    this.reasonsRen,
    required this.nextButtonText,
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
                children: [
                  Expanded(child: pageContent)
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