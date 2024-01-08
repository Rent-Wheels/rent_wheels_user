part of 'files_bloc.dart';

sealed class FilesState extends Equatable {
  const FilesState();

  @override
  List<Object> get props => [];
}

final class FilesInitial extends FilesState {}

final class GetFileUrlLoading extends FilesState {}

final class GetFileUrlLoaded extends FilesState {
  final String fileUrl;

  const GetFileUrlLoaded({required this.fileUrl});
}

final class DeleteFileLoading extends FilesState {}

final class DeleteFileLoaded extends FilesState {}

final class DeleteDirectoryLoading extends FilesState {}

final class DeleteDirectoryLoaded extends FilesState {}

final class GenericFilesError extends FilesState {
  final String errorMessage;

  const GenericFilesError({required this.errorMessage});
}
