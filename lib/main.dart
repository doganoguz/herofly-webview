// @dart=2.9

//bu bir Doğan Oğuz projesidir. 2023

//"Akımdır alternatif olan Allah korusun nazardan" - Nikola TESLA

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:herofly_webview_demo/core/service/notification/PushNotificationService.dart';
import 'package:herofly_webview_demo/ui/page/home/home.dart';
import 'package:herofly_webview_demo/ui/page/onboard/onboard.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _initPlatformState() async {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
      FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    });

    await PushNotificationService().setupInteractedMessage();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {}
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Astsubaylar',
        debugShowCheckedModeBanner: false,
        initialRoute: '/onboard',
        routes: <String, WidgetBuilder>{
          '/onboard': (BuildContext context) => const Onboard(),
          '/home': (BuildContext context) => const Home(),
        });
  }
}
