part of '../../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController urlController;
  @override
  void initState() {
    urlController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadState>(
      listener: (context, state) {
        if (state.status == DownloadStauts.error) {
          log('error');
        } else if (state.status == DownloadStauts.loading) {
          // log('loading....');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Media Downloader'),
          ),
          body: state.image != null
              ? Column(
                  children: [
                    Image.file(
                      File(state.image ?? ''),
                    )
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 200),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Paste your link here',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
                          controller: urlController,
                        ),
                        const SizedBox(height: 200),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: TextButton(
                            onPressed: () {
                              if (urlController.text.isNotEmpty) {
                                context
                                    .read<DownloadCubit>()
                                    .startDownload(url: urlController.text);
                              } else {}

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const DownloadesScreen(),
                              //   ),
                              // );
                            },
                            child: const Text(
                              'Download',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
