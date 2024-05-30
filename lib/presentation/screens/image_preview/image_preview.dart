import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/core.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({
    Key? key,
    required this.fileName,
    required this.imagePath,
  }) : super(key: key);
  final String fileName;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: DxLightScheme().getBackgroundColor(),
          ),
        ),
        centerTitle: false,
        title: Text(
          fileName,
          style: TextStyle(
            fontSize: 20,
            color: DxLightScheme().getBackgroundColor(),
          ),
        ),
      ),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
