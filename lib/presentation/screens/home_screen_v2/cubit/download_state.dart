// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'download_cubit.dart';

enum DownloadStauts {
  intial,
  loaded,
  loading,
  error,
}

class DownloadState extends Equatable {
  const DownloadState({
    required this.status,
    required this.imageList,
    required this.error,
  });
  final DownloadStauts status;
  final List<ImageDataModel> imageList;
  final String error;

  factory DownloadState.initial() {
    return const DownloadState(
      status: DownloadStauts.intial,
      imageList: [],
      error: '',
    );
  }
  @override
  List<Object> get props => [status, imageList, error];

  DownloadState copyWith({
    DownloadStauts? status,
    List<ImageDataModel>? imageList,
    String? error,
  }) {
    return DownloadState(
      status: status ?? this.status,
      imageList: imageList ?? this.imageList,
      error: error ?? this.error,
    );
  }
}
