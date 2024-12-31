import 'package:flutter/material.dart';

import 'flat_list_selector.dart';

class FlatListSelectorFormField extends FormField<int?> {
  FlatListSelectorFormField({
    super.key,
    required String label,
    required List<Map<String, dynamic>> vehicleTypes,
    String? initialValue,
    FormFieldSetter<int?>? onSaved,
    ValueChanged<int?>? onChanged,
    super.validator,
  }) : super(
    initialValue: initialValue != null
        ? vehicleTypes.indexWhere((type) => type['label'] == initialValue)
        : null,
    onSaved: (value) {
      if (value != null && onSaved != null) {
        onSaved(value);
      }
    },
    builder: (FormFieldState<int?> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatListSelector(
            label: label,
            vehicleTypes: vehicleTypes,
            initialValue: state.value != null
                ? vehicleTypes[state.value!]['label']
                : null,
            onSelected: (int index) {
              state.didChange(index);
              if (onChanged != null) {
                onChanged(index); // Trigger the onChanged callback
              }
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