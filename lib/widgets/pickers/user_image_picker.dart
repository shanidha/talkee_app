import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? pickedImage) imagePickerFn;
  UserImagePicker(this.imagePickerFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );
      if (pickedImage == null) return;

      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      widget.imagePickerFn(_pickedImage);
    } on PlatformException catch (e) {
      print('Failed to pick Image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Color.fromARGB(133, 143, 5, 185),
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage!) as ImageProvider
              : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Color.fromARGB(
                133, 143, 5, 185), //Theme.of(context).primaryColor,
          ),
          icon: Icon(Icons.image),
          onPressed: _pickImage,
          label: Text('Add an Image'),
        ),
      ],
    );
  }
}
