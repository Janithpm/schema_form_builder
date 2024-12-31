import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_type.dart';
import 'file_selector_type.dart';

class ImageSelector extends StatefulWidget {
  final String label;
  final String? placeholder;
  final Function(File?) onImageSelect;
  final File? image;
  final Future<File?> Function(File)? compressionFn;
  final CameraType? camera;
  final FileSelectorType? fileSelectorType;
  final dynamic reasonsRen;
  final String buttonText;
  final String buttonSelectedText;

  const ImageSelector({
    super.key,
    required this.label,
    required this.onImageSelect,
    this.image,
    this.compressionFn,
    this.camera,
    this.fileSelectorType,
    this.placeholder,
    this.reasonsRen,
    required this.buttonText,
    required this.buttonSelectedText
  });

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final ImagePicker _picker = ImagePicker();
  File? _imagePreview;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if(widget.image != null) _imagePreview = widget.image;
    // _checkPermissions();
  }

  // Future<void> _checkPermissions() async {
  //   final cameraStatus = await Permission.camera.status;
  //   final photosStatus = await Permission.photos.status;
  //   if (cameraStatus.isDenied || photosStatus.isDenied) {
  //     await [Permission.camera, Permission.photos].request();
  //   }
  // }

  Future<void> _select(ImageSource source) async {
    try {
      // await _checkPermissions();
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;
      final originalFile = File(pickedFile.path);

      File? processedImage;
      // if (isJpg(originalFile)) {
        processedImage = originalFile;
      // } else {
      //   processedImage = await convertToJpg(originalFile);
      // }

      processedImage = widget.compressionFn != null ? await widget.compressionFn!(processedImage) : processedImage;

      setState(() {
        _isUploading = true;
        _imagePreview = processedImage;
      });
      widget.onImageSelect(processedImage);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _remove() {
    setState(() {
      _imagePreview = null;
    });
    widget.onImageSelect(null);
  }

  Widget _preview() {
    if(_isUploading){
      return const Center(child: CircularProgressIndicator());
    }
    if (_imagePreview != null && _imagePreview!.existsSync()) {
      return Image.file(_imagePreview!, fit: BoxFit.cover);
    }

    if(widget.placeholder != null) {
      return Center(child: Image.asset(widget.placeholder!));
    }

    return const Center(child: Icon(Icons.camera_enhance_outlined));
  }

  void selectMode() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final theme = Theme.of(context);

        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Select an option',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if(widget.fileSelectorType == null || widget.fileSelectorType == FileSelectorType.camera || widget.fileSelectorType == FileSelectorType.both)
                    OptionButton(
                      label: 'Camera',
                      icon: Icons.camera_alt_outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        _select(ImageSource.camera);
                      },
                    ),
                  if(widget.fileSelectorType == null || widget.fileSelectorType == FileSelectorType.both) const SizedBox(width: 20),
                  if(widget.fileSelectorType == null || widget.fileSelectorType == FileSelectorType.gallery || widget.fileSelectorType == FileSelectorType.both)
                    OptionButton(
                      label: 'Gallery',
                      icon: Icons.folder_copy_outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        _select(ImageSource.gallery);
                      },
                    ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _imagePreview = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.titleSmall ),
        const SizedBox(height: 16),
        ...widget.reasonsRen ?? [],
        const SizedBox(height: 16),
        SizedBox(
            height: 250,
            width: double.infinity,
            child: _preview()
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => selectMode(),
                style: OutlinedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surface,
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)
                ),
                //Todo: localization for the button
                child: Text(_imagePreview == null ? widget.buttonText : widget.buttonSelectedText, style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.primary)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const OptionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.colorScheme.primary),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 30),
              const SizedBox(width: 10),
              Text(label, style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.primary)),
            ],
          ),
        ),
      ),
    );
  }
}