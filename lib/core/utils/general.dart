import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

showToast({required String message,
  bool vibrate = true,
  bool isErrorMessage = false}) {
  Fluttertoast.cancel();
  if (message == 'Unauthenticated.') {
    return;
  }
  Fluttertoast.showToast(
      msg: message,
      toastLength: isErrorMessage ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);

  if (isErrorMessage) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}

Future<XFile> compressImage(String path,) async {
  String extension = path
      .split('.')
      .last;

  final dir = await getTemporaryDirectory();

  final tmpDir = dir.path;
  final target = "$tmpDir/${DateTime
      .now()
      .millisecondsSinceEpoch}.jpg";
  var result = await FlutterImageCompress.compressAndGetFile(
    path,
    target,
    quality: 80,
    minWidth: 1024,
    minHeight: 1024,
  );

  return result!;
}

String currency='ل.س';