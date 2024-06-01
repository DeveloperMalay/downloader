part of '../remote.dart';

abstract class DonwloadFileClient {
  Future<Result<Success<File>, String>> downloadFile();
}
