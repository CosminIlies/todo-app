import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todo_app/services/database_service.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Title: ${message.data}');
}

class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: ${fCMToken}");
    await DatabaseService.storeFCMToken(fCMToken!);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
