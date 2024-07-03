
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class Utils{

  static Future<String> pickAndConvertImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return ""; // Handle user canceling image selection
    }

    final imageFile = File(pickedFile.path);
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    return base64Image;
  }

  static Uint8List base64Decode(String base64){
    Uint8List image;
    image = Base64Decoder().convert(base64);
    return image;
  }
}