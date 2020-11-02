import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  Future _futureGetPath;
  List<dynamic> listImagePath = List<dynamic>();
  var _permissionStatus;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();

    _futureGetPath = ExtStorage.getExternalStoragePublicDirectory(
        '/Android/data/com.example.projectflutter/files/pictures');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  // print('permission status: $_permissionStatus');
                  if (_permissionStatus) _fetchFiles(dir);
                  return Text(""); // snapshot.data
                } else {
                  // return Text("Loading");
                }
              },
            ),
          ),
          Expanded(
            flex: 19,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: _getListImg(listImagePath),
            ),
          )
        ],
      ),
    );
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    setState(() => _permissionStatus = status);
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = List<dynamic>();
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp)", caseSensitive: false);
      
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
      });
    });
  }

  List<Widget> _getListImg(List<dynamic> listImagePath) {
    List<Widget> listImages = List<Widget>();
    for (var imagePath in listImagePath) {
      listImages.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.file(imagePath, fit: BoxFit.cover),
        ),
      );
    }
    return listImages;
  }
}