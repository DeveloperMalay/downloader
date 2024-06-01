part of '../remote.dart';

abstract class DonwloadFileClient {
  Future<Result<Success<File>, String>> downloadFile(String url);
}

@Injectable(as: DonwloadFileClient)
class DonwloadFileClientImpl extends DonwloadFileClient {
  @override
  Future<Result<Success<File>, String>> downloadFile(String url) async {
    HttpClient httpClient = HttpClient();
    Directory? dir = await getExternalStorageDirectory();
    String dirPath = dir?.path ?? '';
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      final String fileName = Uri.parse(url).path.split("/").last;
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        var filePath = '$dirPath/$fileName';
        File file = File(filePath);
        File downloadedFile = await file.writeAsBytes(bytes);
        return Result(response: Success(data: downloadedFile));
      } else {
        return Result(error: 'Error code: ${response.statusCode}');
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
