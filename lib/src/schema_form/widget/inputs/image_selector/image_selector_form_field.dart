import 'dart:io';
import 'package:flutter/material.dart';

import 'camera_type.dart';
import 'file_selector_type.dart';
import 'image_selector.dart';

class ImageSelectorFormField extends FormField<File?> {
  ImageSelectorFormField({
    super.key,
    required String label,
    String? placeholder,
    Future<File?> Function(File)? compressionFn,
    super.initialValue,
    super.onSaved,
    super.validator,
    CameraType? camera,
    FileSelectorType? fileSelectorType,
    dynamic reasonsRen,
    required String buttonText,
    required String buttonSelectedText,

  }) : super(
    builder: (FormFieldState<File?> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSelector(
            label: label,
            placeholder: placeholder,
            image: state.value,
            camera: camera,
            reasonsRen: reasonsRen,
            buttonText: buttonText,
            buttonSelectedText: buttonSelectedText,
            fileSelectorType: fileSelectorType,
            compressionFn: compressionFn,
            onImageSelect: (File? image) {
              state.didChange(image);
            },
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                state.errorText ?? '',
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      );
    },
  );
}
