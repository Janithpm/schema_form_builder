import 'form_text.dart';
import 'utils.dart';

class ImageContent {
  final String imageUrl;
  final FormText? caption;

  ImageContent({ required this.imageUrl, this.caption});

  factory ImageContent.fromMap(Map<String, dynamic> map) {
    return ImageContent(
      imageUrl: map['imageUrl'],
      caption: getValue<FormText>(map, 'caption', (caption) => FormText.fromMap(caption)),
    );
  }
}