import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';

class ImageUtil {
  static Future<Directory> _getTemporaryDirectory() async {
    return Directory.systemTemp;
  }

  static Future<File> compressImage(File imageFile, int quality) async {
    var uniqueString = Uuid().v1();
    File finalImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      await _getTemporaryDirectory()
          .then((v) => "${v.path + uniqueString}.jpg"),
      quality: quality,
      minHeight: 400,
      minWidth: 400,
    );
    return finalImage;
  }

  static String getBase64Image(File imageFile){
    List<int> imageBytes = imageFile.readAsBytesSync();
//    print(imageBytes);
    var img = "data:image/jpg;base64," + base64Encode(imageBytes);
//    print(img);
    return img;

  }
}
