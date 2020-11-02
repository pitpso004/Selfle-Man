import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Camera extends StatefulWidget {
  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  File _image;

  camera() async {
  await ImagePicker.pickImage(source: ImageSource.camera).then((img) {
      setState(() {
        _image = img;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(Icons.camera),
            color: Colors.white,
            onPressed: () {camera();},
          ),
        ),
      ),
    );
  }
}