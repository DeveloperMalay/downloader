part of '../../presentation.dart';

class DxHomeScreen extends StatefulWidget {
  const DxHomeScreen({super.key});

  @override
  State<DxHomeScreen> createState() => _DxHomeScreenState();
}

class _DxHomeScreenState extends State<DxHomeScreen> {
  bool showSearch = false;
  late TextEditingController urlController;
  late DownloadCubit _downloadCubit;
  @override
  void initState() {
    urlController = TextEditingController();
    _downloadCubit = context.read<DownloadCubit>();
    _downloadCubit.getDownloadedImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadState>(
      listener: (context, state) {
        if (state.status == DownloadStauts.loading) {
          BotToast.showLoading();
        } else {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: showSearch
                ? DxSearchFieldWidget(
                    controller: urlController,
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
                        if (urlController.text.isNotEmpty) {
                          context
                              .read<DownloadCubit>()
                              .startDownload(url: urlController.text);
                          urlController.clear();
                          setState(() {
                            showSearch = !showSearch;
                          });
                        }
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
          body: state.imageList.isEmpty
              ? const Center(
                  child: Text('No downloaded images'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    return DxDownlodedMedia(
                      imagePath: state.imageList[index].filePath,
                      fileName: state.imageList[index].fileName,
                      fileSize: state.imageList[index].fileSize,
                      date: state.imageList[index].downloadDate,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: state.imageList.length,
                ),
        );
      },
    );
  }
}
