import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModal extends StatefulWidget {
  final Function(File)? onImageSelected;
  const ImagePickerModal({Key? key, this.onImageSelected}) : super(key: key);

  @override
  State<ImagePickerModal> createState() => _ImagePickerModalState();
}

class _ImagePickerModalState extends State<ImagePickerModal> {
  File? image;
  void pickImageFromGallery() async {
    try {
      final image =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        if (widget.onImageSelected != null) {
          widget.onImageSelected!(imageTemporary);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void pickImageFromCamera() async {
    try {
      final image =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        if (widget.onImageSelected != null) {
          widget.onImageSelected!(imageTemporary);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick an avatar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => pickImageFromGallery(),
            child: Text('Galery'),
          ),
          ElevatedButton(
            onPressed: () => pickImageFromCamera(),
            child: Text('Camera'),
          ),
        ],
      ),
    );
  }
}
