import 'dart:io';

import 'package:downloader/presentation/screens/image_preview/image_preview.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class DxDownlodedMedia extends StatelessWidget {
  const DxDownlodedMedia({
    super.key,
    this.imagePath,
    required this.fileName,
    required this.fileSize,
    required this.date,
  });
  final String? imagePath;
  final String fileName;
  final String fileSize;
  final String date;
  final img =
      'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg?auto=compress&cs=tinysrgb&w=600';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePreviewScreen(
                    fileName: fileName,
                    imagePath: imagePath ?? "",
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(imagePath ?? ''),
                height: 50,
                width: 50,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/error.png',
                  height: 50,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: DxLightScheme().getPrimaryTextColor(),
                  ),
                ),
              ),
              Text(
                fileSize,
                style: TextStyle(
                  fontSize: 12,
                  color: DxLightScheme().getPrimaryTextColor(),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: DxLightScheme().getPrimaryTextColor(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
