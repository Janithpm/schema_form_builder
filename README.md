# schema_form_builder

A Flutter package to dynamically generate forms from JSON schemas. This package simplifies form creation by enabling developers to define forms through JSON, reducing boilerplate code and making form customization more accessible.

## Features

- **JSON-based Form Generation**: Build complex forms quickly using JSON schema definitions.
- **Validation**: Support for various validation rules like required fields, min/max lengths, etc.
- **Localization**: Easily localize form fields into multiple languages.
- **Custom Widgets**: Extend functionality with custom field types and UI components.
- **Media Capture**: Capture images via camera or gallery directly from the form.

## Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  schema_form_builder: ^0.0.1
```

Then, run:

```bash
flutter pub get
```

## Usage

### 1. Import the package

```dart
import 'package:schema_form_builder/schema_form_builder.dart';
```

### 2. Define a JSON Schema

```dart
const formSchema = {
  "pages": [
    {
      "name": "driverDetails",
      "title": {"en": "Driver Details"},
      "fields": [
        {
          "type": "text",
          "name": "driverName",
          "label": {"en": "Driver Name"},
          "validation": {"required": true, "minLength": 3}
        },
        {
          "type": "capture",
          "camera": "back",
          "gallery": true,
          "name": "driverLicenseFront",
          "label": {"en": "Driver License - Front"},
          "validation": {"required": true},
          "custom": {"placeholder": "assets/images/license-front.png"}
        }
      ]
    }
  ]
};
```

### 3. Render the Form

```dart
SchemaForm.builder(
  schema: formSchema,
  locale: 'en', // Specify language locale
  onSubmit: (data) {
    print("Form submitted with data: \$data");
  },
  builder: (context, form, options) {
    return Scaffold(
      appBar: AppBar(title: Text(options.title)),
      body: Padding(padding: EdgeInsets.all(16), child: form),
    );
  },
);
```

## Example

Here's a form rendered from the schema above:

![Form Screenshot](https://via.placeholder.com/600x300?text=Form+Screenshot)

## Supported Field Types

- **Text**: Single-line text inputs
- **Capture**: Image capture via camera or gallery
- **Dropdown**: Select from predefined options (coming soon)
- **Checkbox**: Toggle options (coming soon)

## Roadmap

- Add support for more field types like radio buttons, sliders, and date pickers.
- Improve validation support with custom error messages.
- Enable schema-based conditional field visibility.

## Contributions

Contributions are welcome! If you’d like to add new features or fix bugs, please submit a pull request or open an issue in the [GitHub repository](https://github.com/JanithPM/schema_form_builder).

## License

This project is licensed under the [MIT License](LICENSE).
