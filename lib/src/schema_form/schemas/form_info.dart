import 'form_text.dart';

class FormInfo {
  final String type;
  final FormText text;
  final String? alignment;
  final String? url;
  final double? height;
  final double? width;

  FormInfo({
    required this.type,
    required this.text,
    this.alignment,
    this.url,
    this.height,
    this.width,
  });

  factory FormInfo.fromMap(Map<String, dynamic> infoMap) {
    return FormInfo(
      type: infoMap['type'],
      text: FormText.fromMap(infoMap['text']),
      alignment: infoMap['alignment'],
      url: infoMap['url'],
      height: infoMap['height']?.toDouble(),
      width: infoMap['width']?.toDouble(),
    );
  }

  // Get localized text based on locale
  String getText(String locale) {
    return text.getText(locale);
  }

  // Get alignment or default to 'left'
  String getAlignment() {
    return alignment ?? 'left';
  }

  // Get URL or default to an empty string
  String getUrl() {
    return url ?? '';
  }

  // Get height or default to 0.0
  double getHeight() {
    return height ?? 0.0;
  }

  // Get width or default to 0.0
  double getWidth() {
    return width ?? 0.0;
  }
}