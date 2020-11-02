import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Camera extends StatefulWidget {
  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  File _image;

  Future camera() async {
    final img = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(img.path);
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