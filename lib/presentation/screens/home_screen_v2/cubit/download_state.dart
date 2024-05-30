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
  });
  final DownloadStauts status;
  final List<ImageDataModel> imageList;
  factory DownloadState.initial() {
    return const DownloadState(status: DownloadStauts.intial, imageList: []);
  }
  @override
  List<Object> get props => [status, imageList];

  DownloadState copyWith({
    DownloadStauts? status,
    List<ImageDataModel>? imageList,
  }) {
    return DownloadState(
      status: status ?? this.status,
      imageList: imageList ?? this.imageList,
    );
  }
}
