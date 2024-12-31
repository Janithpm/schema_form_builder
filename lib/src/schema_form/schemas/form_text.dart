class FormText {
  final String en;
  final String si;
  final String ta;

  FormText({
    required this.en,
    required this.si,
    required this.ta,
  });

  factory FormText.fromMap(Map<String, dynamic> textMap) {
    return FormText(
      en: textMap['en'],
      si: textMap['si'],
      ta: textMap['ta'],
    );
  }

  String getText(String locale) {
    switch (locale) {
      case 'si':
        return si;
      case 'ta':
        return ta;
      default:
        return en;
    }
  }
}