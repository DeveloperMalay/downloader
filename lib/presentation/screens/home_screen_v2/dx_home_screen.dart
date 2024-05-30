import 'package:downloader/presentation/screens/home_screen_v2/widgets/dx_search_field.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'widgets/dx_download_button.dart';
import 'widgets/dx_downloaded_media.dart';

class DxHomeScreen extends StatefulWidget {
  const DxHomeScreen({super.key});

  @override
  State<DxHomeScreen> createState() => _DxHomeScreenState();
}

class _DxHomeScreenState extends State<DxHomeScreen> {
  bool showSearch = false;
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: showSearch
            ? DxSearchFieldWidget(
                controller: controller,
                onInputChanged: (value) {},
              )
            : Text(
                'Media Downloader',
                style: TextStyle(
                  fontSize: 20,
                  color: DxLightScheme().getBackgroundColor(),
                ),
              ),
        actions: [
          showSearch
              ? DxDownloadButton(
                  onClick: () {
                    setState(() {
                      showSearch = !showSearch;
                    });
                  },
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      showSearch = !showSearch;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: DxLightScheme().getBackgroundColor(),
                  ),
                )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          return const DxDownlodedMedia(
            image:
                'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg?auto=compress&cs=tinysrgb&w=600',
            fileName: 'Filename',
            fileSize: '10 Mb',
            date: '12/12/2023',
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 100,
      ),
    );
  }
}
