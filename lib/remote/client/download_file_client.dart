part of '../remote.dart';

abstract class DonwloadFileClient {
  Future<Result<Success<File>, String>> downloadFile(String url);
}

@Injectable(as: DonwloadFileClient)
class DonwloadFileClientImpl extends DonwloadFileClient {
  @override
  Future<Result<Success<File>, String>> downloadFile(String url) async {
    HttpClient httpClient = HttpClient();
    Directory? dir;
    if (Platform.isAndroid) {
      log('is android ${Platform.isAndroid}');
      dir = (await getExternalStorageDirectory())!;
    } else if (Platform.isIOS) {
      log('is IOS ${Platform.isIOS}');
      dir = await getApplicationDocumentsDirectory();
    } else {
      return Result(error: 'Unsupported platform');
    }
    String dirPath = dir.path;
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();

      final String fileName = Uri.parse(url).path.split("/").last;
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        log('length ${(bytes.length * 0.000001).toStringAsFixed(2)} MB');
        var filePath = '$dirPath/$fileName';
        File file = File(filePath);
        File downloadedFile = await file.writeAsBytes(bytes);
        return Result(response: Success(data: downloadedFile));

        // var totalBytes = response.contentLength;
        // var bytesDownloaded = 0;

        // var filePath = '$dirPath/$fileName';
        // File file = File(filePath);
        // var raf = file.openSync(mode: FileMode.write);

        // Completer<Result<Success<File>, String>> completer = Completer();

        // response.listen((chunk) {
        //   bytesDownloaded += chunk.length;
        //   raf.writeFromSync(chunk);
        //   double progress = bytesDownloaded / totalBytes;
        //   var lenfth = (file.lengthSync() * 0.000001).toStringAsFixed(2);
        //   int count = int.tryParse(lenfth) ?? 0;
        //   int i = int.tryParse(progress.toString()) ?? 0;
        //   NotificationService().createNotification(count, i, 0);
        // }, onDone: () {
        //   raf.closeSync();
        //   completer.complete(Result(response: Success(data: file)));
        // }, onError: (e) {
        //   raf.closeSync();
        //   completer.complete(Result(error: e.toString()));
        // }, cancelOnError: true);

        // return completer.future;
      } else {
        return Result(error: 'Error code: ${response.statusCode}');
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
