import 'dart:io';

import 'package:downloader/data/data.dart';
import 'package:downloader/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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



//  Future<PlatformFile?> urlToPlatformFile() async {
//     try {
//       if (this == null || (this?.isEmpty ?? true)) {
//         return null;
//       }

//       http.Response response = await http.get(Uri.parse(this!));
//       if (response.statusCode == 200) {
//         Uint8List bytes = response.bodyBytes;

//         PlatformFile platformFile = PlatformFile(
//             path: this,
//             name: getFileNameFromPath(),
//             bytes: bytes,
//             size: bytes.lengthInBytes,
//             identifier: this);

//         return platformFile;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }