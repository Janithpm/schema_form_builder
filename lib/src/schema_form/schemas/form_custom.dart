class FormCustom {
  final Map<String, dynamic> attributes;

  FormCustom({
    required this.attributes,
  });

  factory FormCustom.fromMap(Map<String, dynamic> customMap) {
    return FormCustom(
      attributes: customMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attributes': attributes,
    };
  }

  FormCustom copyWith({
    Map<String, dynamic>? attributes,
  }) {
    return FormCustom(
      attributes: attributes ?? this.attributes,
    );
  }

  dynamic getValue(String key) {
    if (attributes.containsKey(key)) {
      return attributes[key];
    }
    return null;
  }

  FormCustom setValue(String key, dynamic value) {
    return FormCustom(
      attributes: {
        ...attributes,
        key: value,
      },
    );
  }

  Map<String, dynamic> toJson() => toMap();
}