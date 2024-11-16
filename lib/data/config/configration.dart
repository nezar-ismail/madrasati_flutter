import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';


class Configration {
  static String? appVersion;



  static Future<dynamic> isUptoDate() async {
    final config = await getIt<AuthService>().getConfig();
    final localVersion = await SecureStorageApi.instance.getVersion();
    await SecureStorageApi.instance.setIpAddress(config['ipAddress']);
    
    if (config['version'] != localVersion) {
      return {
        'version': config['version'],
        'url': config['url'],};
    }
    return config['version'] == localVersion;
  }

}
