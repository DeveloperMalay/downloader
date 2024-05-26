import 'package:downloader/presentation/screens/downloads/widget/media_preview.dart';
import 'package:flutter/material.dart';

class DownloadesScreen extends StatefulWidget {
  const DownloadesScreen({super.key});

  @override
  State<DownloadesScreen> createState() => _DownloadesScreenState();
}

class _DownloadesScreenState extends State<DownloadesScreen> {
  var list = List.generate(10, (index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('list of media'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => MediaPreview(index: index),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: list.length)
          ],
        ),
      ),
    );
  }
}
