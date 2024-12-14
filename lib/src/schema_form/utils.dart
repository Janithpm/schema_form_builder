String t(dynamic text, String? locale) {
  if (locale != null && text is Map) {
    return text[locale] ?? text['en'] ?? '';
  }
  return text;
}