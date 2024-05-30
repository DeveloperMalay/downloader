import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class DxDownlodedMedia extends StatelessWidget {
  const DxDownlodedMedia({
    super.key,
    required this.image,
    required this.fileName,
    required this.fileSize,
    required this.date,
  });
  final String image;
  final String fileName;
  final String fileSize;
  final String date;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              height: 50,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: DxLightScheme().getPrimaryTextColor(),
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
