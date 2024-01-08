import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FilesRemoteDatasource {
  Future<String> getFileUrl(Map<String, dynamic> params);
  Future<void> deleteFile(Map<String, dynamic> params);
  Future<void> deleteDirectory(Map<String, dynamic> params);
}

class FilesRemoteDatasourceImpl implements FilesRemoteDatasource {
  final FirebaseStorage storage;

  FilesRemoteDatasourceImpl({required this.storage});

  @override
  Future<void> deleteDirectory(Map<String, dynamic> params) async {
    List<Reference> files = [];

    final ref = storage.ref().child(params['directoryPath']);

    final refs = await ref.listAll();
    for (var prefix in refs.prefixes) {
      final list = await prefix.listAll();
      if (list.items.isNotEmpty) {
        files.addAll(list.items);
      }
    }
    for (var file in files) {
      await file.delete();
    }
  }

  @override
  Future<void> deleteFile(Map<String, dynamic> params) async {
    final ref = storage.ref().child(params['filePath']);
    return await ref.delete();
  }

  @override
  Future<String> getFileUrl(Map<String, dynamic> params) async {
    final file = params['file'] as File;

    final ref = storage.ref().child(params['filePath']);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});

    return await snapshot.ref.getDownloadURL();
  }
}
