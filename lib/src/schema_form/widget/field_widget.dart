import 'dart:io';
import 'package:flutter/material.dart';
import '../schemas/form_custom.dart';
import '../schemas/form_input_field.dart';
import 'inputs/image_selector/file_selector_type.dart';
import 'inputs/image_selector/image_selector_form_field.dart';

class FieldWidget extends StatelessWidget {
  final FormInputField field;
  final String locale;
  final Function(String) getValue;
  final Function(String, dynamic) setValue;
  final dynamic reasonsRen;

  const FieldWidget(
      {super.key,
      required this.field,
      required this.locale,
      required this.getValue,
      required this.setValue,
      this.reasonsRen});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (field.type) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: field.label.getText(locale)),
            initialValue: getValue(field.name),
            onChanged: (value) => setValue(field.name, value),
            validator: (value) {
              if (field.validation?.required == true &&
                  (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              if (field.validation?.minLength != null &&
                  value!.length < field.validation!.minLength!) {
                return 'Minimum length is ${field.validation!.minLength}';
              }
              return null;
            },
          ),
        );
      case 'capture':
        return Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ImageSelectorFormField(
                label: field.label.getText(locale),
                placeholder: field.custom?.attributes['placeholder'] ?? '',
                compressionFn: (File file) async {
                  return file;
                },
                reasonsRen: reasonsRen,
                buttonText: 'Upload',
                buttonSelectedText: 'Upload Again',
                initialValue: getValue(field.name)?.file,
                fileSelectorType: getFileType(
                    field.custom?.attributes['fileSelectorType'] ?? 'both'),
                onSaved: (image) {
                  if (image != null) {
                    setValue(field.name,
                        ImageDataPacket(custom: field.custom, file: image));
                  }
                },
                validator: (File? image) {
                  if (field.validation?.required == true && image == null) {
                    return 'An image is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

getFileType(String type) {
  switch (type) {
    case 'camera':
      return FileSelectorType.camera;
    case 'gallery':
      return FileSelectorType.gallery;
    case 'both':
      return FileSelectorType.both;
    default:
      return FileSelectorType.both;
  }
}

class ImageDataPacket {
  final FormCustom? custom;
  final File? file;

  ImageDataPacket({
    required this.custom,
    required this.file,
  });

  // when printing the object show all the data as json
  @override
  String toString() {
    return "{custom: ${custom?.toMap().toString()}, file: ${file.toString()}}";
  }
}
