import 'dart:io';
import 'package:downloader/data/data.dart';
import 'package:downloader/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/image_data_model.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState.initial());

  late DownloadFileUseCase _downloadFileUseCase;

  void initialize() {
    _downloadFileUseCase = GetIt.instance.get<DownloadFileUseCase>();
  }

  void downloadFiles({required String url}) async {
    emit(state.copyWith(status: DownloadStauts.loading));
    try {
      Result<File, String> data = await _downloadFileUseCase.execute(url);
      if (data.response != null) {
        emit(state.copyWith(status: DownloadStauts.loaded));
      } else {
        emit(state.copyWith(status: DownloadStauts.error, error: data.error));
      }
    } catch (e) {
      emit(state.copyWith(status: DownloadStauts.error, error: e.toString()));
    }
    getDownloadedImages();
  }

  // void startDownload({required String url}) async {
  //   emit(state.copyWith(status: DownloadStauts.loading));
  //   Directory? dir = await getExternalStorageDirectory();
  //   String dirPath = dir?.path ?? '';
  //   try {
  //     var result = await downloadFile(url, dirPath);
  //     emit(state.copyWith(status: DownloadStauts.loaded));
  //     log('result $result');
  //   } catch (e) {
  //     emit(state.copyWith(status: DownloadStauts.error));
  //   }
  //   getDownloadedImages();
  // }

  // Future<String> downloadFile(String url, String dir) async {
  //   HttpClient httpClient = HttpClient();
  //   File file;
  //   String filePath = '';

  //   try {
  //     var request = await httpClient.getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     final String fileName = Uri.parse(url).path.split("/").last;
  //     if (response.statusCode == 200) {
  //       var bytes = await consolidateHttpClientResponseBytes(response);
  //       filePath = '$dir/$fileName';
  //       file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //     } else {
  //       filePath = 'Error code: ${response.statusCode}';
  //     }
  //   } catch (ex) {
  //     filePath = 'Can not fetch url';
  //   }

  //   return filePath;
  // }

  void getDownloadedImages() async {
    emit(state.copyWith(status: DownloadStauts.loading));
    Directory? dir = await getExternalStorageDirectory();
    List<FileSystemEntity>? dirList = dir?.listSync();
    List<ImageDataModel> files = (dirList ?? []).map((file) {
      File fileData = File(file.path);
      return ImageDataModel(
        filePath: file.path,
        fileName: file.path.split("/").last,
        fileSize: '${(fileData.lengthSync() * 0.000001).toStringAsFixed(2)} MB',
        downloadDate:
            fileData.lastModifiedSync().toIso8601String().split('T').first,
      );
    }).toList();
    emit(state.copyWith(imageList: files, status: DownloadStauts.loaded));
  }
}

// class DownloadProvider extends ChangeNotifier {
//   final _progressList = <double>[];

//   void download(String downloadUrl, int index) async {
//     NotificationService notificationService = NotificationService();

//     final String fileName = Uri.parse(downloadUrl).path.split("/").last;

//     final dio = Dio();

//     try {
//       dio.download(downloadUrl, "/storage/emulated/0/Download/$fileName",
//           onReceiveProgress: ((count, total) async {
//         await Future.delayed(const Duration(seconds: 1), () {
//           _progressList[index] = (count / total);
//           notificationService.createNotification(
//               100, ((count / total) * 100).toInt(), index);
//           notifyListeners();
//         });
//       }));
//     } on DioError catch (e) {
//       print("error downloading file $e");
//     }
//   }
// }

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('ic_launcher');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i, int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'progress channel',
      'progress channel',
      channelDescription: 'progress channel description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: count,
      progress: i,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(id, 'progress notification title',
        'progress notification body', platformChannelSpecifics,
        payload: 'item x');
  }
}
