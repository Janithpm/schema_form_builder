class LocalizeText {
  String si;
  String ta;
  String en;

  LocalizeText({
    required this.si,
    required this.ta,
    required this.en,
  });

  factory LocalizeText.fromJson(Map<String, dynamic> json) {
    return LocalizeText(
      si: json['si'],
      ta: json['ta'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['si'] = si;
    data['ta'] = ta;
    data['en'] = en;
    return data;
  }
}