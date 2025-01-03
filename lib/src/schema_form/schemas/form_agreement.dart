class FormAgreement {
  final String id;
  final String version;
  final bool required;

  FormAgreement({
    required this.id,
    required this.version,
    required this.required,
  });

  factory FormAgreement.fromMap(Map<String, dynamic> agreementMap) {
    return FormAgreement(
      id: agreementMap['id'],
      version: agreementMap['version'],
      required: agreementMap['required'],
    );
  }
}