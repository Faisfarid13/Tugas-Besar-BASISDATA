import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class notificationHandler{
  initializeNotification()async{
    final fcm = FirebaseMessaging.instance;
    final message = await fcm.getInitialMessage();

    if(message != null){
      final data = message.data;
      debugPrint("kamu bisa melakukan apapun dengan data! $data");
    }

    try{
      if(Platform.isAndroid){
        await fcm.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        await fcm.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        FirebaseMessaging.onMessage.listen(_onMessage);
        FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(_onOpened);
      }
      print('aman');
      debugPrint("Token : ${(await FirebaseMessaging.instance.getToken()).toString()}");

    }catch(e){
      debugPrint(e.toString());
      print('gagal');
    }
  }

  void _onMessage(RemoteMessage message) async{
    debugPrint('Kamu menerima pesan on message! ${message.notification?.title}');
    debugPrint("${message.notification?.body}");
  }

  Future<void> _onBackgroundMessage(RemoteMessage message) async{
    debugPrint('Kamu menerima pesan bg message! ${message.notification?.title}');
    debugPrint("${message.notification?.body}");
  }

  void _onOpened(RemoteMessage message)async{
    final data = message.data;
    debugPrint('<--- KAMU MEMBUKA NOTIF --->');
  }

}