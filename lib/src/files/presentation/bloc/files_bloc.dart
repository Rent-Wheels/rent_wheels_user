import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/files/domain/usecases/delete_directory.dart';
import 'package:rent_wheels/src/files/domain/usecases/delete_file.dart';
import 'package:rent_wheels/src/files/domain/usecases/get_file_url.dart';

part 'files_event.dart';
part 'files_state.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  final GetFileUrl getFileUrl;
  final DeleteFile deleteFile;
  final DeleteDirectory deleteDirectory;
  FilesBloc({
    required this.getFileUrl,
    required this.deleteFile,
    required this.deleteDirectory,
  }) : super(FilesInitial()) {
    on<GetFileUrlEvent>((event, emit) async {
      emit(GetFileUrlLoading());

      final response = await getFileUrl(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFilesError(errorMessage: errorMessage),
          (response) => GetFileUrlLoaded(fileUrl: response),
        ),
      );
    });

    on<DeleteFileEvent>((event, emit) async {
      emit(DeleteFileLoading());

      final response = await deleteFile(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFilesError(errorMessage: errorMessage),
          (_) => DeleteDirectoryLoaded(),
        ),
      );
    });

    on<DeleteDirectoryEvent>((event, emit) async {
      emit(DeleteDirectoryLoading());

      final response = await deleteDirectory(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFilesError(errorMessage: errorMessage),
          (_) => DeleteDirectoryLoaded(),
        ),
      );
    });
  }
}
