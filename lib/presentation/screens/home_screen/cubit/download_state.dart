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
    this.image,
  });
  final DownloadStauts status;
  final String? image;
  factory DownloadState.initial() {
    return const DownloadState(status: DownloadStauts.intial);
  }
  @override
  List<Object> get props => [status, image ?? ''];

  DownloadState copyWith({
    DownloadStauts? status,
    String? image,
  }) {
    return DownloadState(
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }
}
