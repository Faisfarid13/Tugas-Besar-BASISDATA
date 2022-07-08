import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modul_2/firebase_options.dart';
import 'package:modul_2/searchUI/favoriteSite.dart';
import 'package:provider/provider.dart';
import 'HomeScreen/first.dart';
import 'notification_handler.dart';
import 'package:modul_2/searchUI/favoriteSite.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  notificationHandler notifHandler = notificationHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifHandler.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<favoriteSite>(
      create: (_) => favoriteSite(),
      child: const MaterialApp(
        home: first(),
      ),
    );
  }
}
