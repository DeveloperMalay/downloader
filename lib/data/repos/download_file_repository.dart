part of '../data.dart';

abstract class DownloadFileRepository {
  Future<Result<File, String>> downloadFile(String url);
}

@Injectable(as: DownloadFileRepository)
class DownloadFileRepositoryImpl extends DownloadFileRepository {
  final DonwloadFileClient donwloadFileClient;
  DownloadFileRepositoryImpl({required this.donwloadFileClient});
  @override
  Future<Result<File, String>> downloadFile(String url) async {
    Result res = await donwloadFileClient.downloadFile(url);
    if (res.hasError) {
      return Result(error: res.error);
    }
    var data = res.response;
    return Result(response: data!);
  }
}
