class LibLocalization {
  final Map<String, String> _localization;

  LibLocalization(this._localization);

  String? t(String key) {
    return _localization[key];
  }
}