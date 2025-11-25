import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerRepositoryImpl {
  Future<void> notificationRequest() async {
    await Permission.notification.request();
  }

  // SINGLETONE

  // singleton
  PermissionHandlerRepositoryImpl._();
  static final PermissionHandlerRepositoryImpl _instance =
      PermissionHandlerRepositoryImpl._();

  static PermissionHandlerRepositoryImpl get instance => _instance;
}
