import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<String?> getDeviceId() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // This is the Android device ID
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // This is the iOS device ID
  }
  return null;
}
