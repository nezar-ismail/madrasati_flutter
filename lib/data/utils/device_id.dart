import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

/// Retrieves the device ID for the current platform.
///
/// This function returns a unique device ID based on the platform:
/// - On Android, it returns the Android device ID.
/// - On iOS, it returns the identifier for the vendor.
///
/// Returns `null` if the platform is not supported or if the device ID
/// cannot be retrieved.
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
