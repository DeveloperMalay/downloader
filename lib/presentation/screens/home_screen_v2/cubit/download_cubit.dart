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
      NotificationService().createNotification(100, 10, 0);
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

  void getDownloadedImages() async {
    emit(state.copyWith(status: DownloadStauts.loading));
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    }
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
        InitializationSettings(android: _androidInitializationSettings);
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
