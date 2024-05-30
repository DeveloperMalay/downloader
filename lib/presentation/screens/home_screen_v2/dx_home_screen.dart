import 'package:downloader/presentation/screens/home_screen_v2/widgets/search_field.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'widgets/download_button.dart';

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
    );
  }
}
