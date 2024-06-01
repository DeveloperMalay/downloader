part of '../domain.dart';

@injectable
class DownloadFileUseCase extends UseCase<Result<File, String>, String> {
  final DownloadFileRepository downloadFileRepository;

  DownloadFileUseCase({required this.downloadFileRepository});
  @override
  Future<Result<File, String>> execute(params) {
    return downloadFileRepository.downloadFile(params);
  }
}
