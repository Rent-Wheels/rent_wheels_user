import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class RentWheelsFilesMethods {
  Future<String> getFileUrl({
    required File? file,
    required String filePath,
  }) async {
    final ref = FirebaseStorage.instance.ref().child(filePath);
    final uploadTask = ref.putFile(file!);
    final snapshot = await uploadTask.whenComplete(() {});

    return await snapshot.ref.getDownloadURL();
  }

  Future deleteFile({required String filePath}) async {
    final ref = FirebaseStorage.instance.ref().child(filePath);

    await ref.delete();
  }
}
