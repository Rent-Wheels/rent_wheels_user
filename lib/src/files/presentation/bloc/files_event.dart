part of 'files_bloc.dart';

sealed class FilesEvent extends Equatable {
  const FilesEvent();

  @override
  List<Object> get props => [];
}

final class GetFileUrlEvent extends FilesEvent {
  final Map<String, dynamic> params;

  const GetFileUrlEvent({required this.params});
}

final class DeleteFileEvent extends FilesEvent {
  final Map<String, dynamic> params;

  const DeleteFileEvent({required this.params});
}

final class DeleteDirectoryEvent extends FilesEvent {
  final Map<String, dynamic> params;

  const DeleteDirectoryEvent({required this.params});
}
