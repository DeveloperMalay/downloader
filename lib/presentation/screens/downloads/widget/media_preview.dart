import 'package:flutter/material.dart';

class MediaPreview extends StatelessWidget {
  const MediaPreview({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("index $index"),
    );
  }
}
