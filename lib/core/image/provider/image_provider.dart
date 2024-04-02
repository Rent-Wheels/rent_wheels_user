import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionProvider extends ChangeNotifier {
  final ImagePicker picker;

  ImageSelectionProvider({required this.picker});

  Future<File?> openImage({required ImageSource source}) async {
    final image = await picker.pickImage(source: source);
    return image != null ? File(image.path) : null;
  }
}
