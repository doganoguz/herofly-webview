import 'dart:convert';
import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:herofly_webview_demo/core/service/notification/local.dart';
import 'package:herofly_webview_demo/ui/constant/colors/color.dart';
import 'package:herofly_webview_demo/ui/page/home/home.dart';

import 'package:http/http.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'package:flutter_localization/flutter_localization.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //statusbar color değiştirme
  ));

  WidgetsFlutterBinding.ensureInitialized();
}

class _OnboardState extends State<Onboard> {
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    localNotificationCalistir();
  }

  final FlutterLocalNotificationsPlugin test =
      FlutterLocalNotificationsPlugin();
  void localNotificationCalistir() async {
    Noti.showBigTextNotification(
        title: "👋🏻  Merhaba, Asker!",
        body:
            "🇹🇷 Bu uygulama Herofly, LLC firması tarafından oluşturulmuş bir demo uygulamadır.",
        fln: test);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NowUIColors.black,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, NowUIColors.black])
                    .createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                  height: 480,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://w0.peakpx.com/wallpaper/965/164/HD-wallpaper-tsk-army-asker-military-sniper-soldier-soldiers-special-forces-turk-turk-askeri-turkish-soldier-thumbnail.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Astsubaylar",
                style: GoogleFonts.nunito(
                  color: NowUIColors.beyaz,
                  fontSize: 45,
                ),
              ),
            ],
          ),
          //rubikgltach, puddles iyimiş
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: DefaultTextStyle(
                  style: GoogleFonts.nunito(
                    color: NowUIColors.beyaz,
                    fontSize: 14,
                  ),
                  child: AnimatedTextKit(
                    pause: const Duration(milliseconds: 1000),
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Biz Astsubaylar... 🇹🇷 Çok Yakında Sizlerle!'),
                    ],
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SwipeableButtonView(
              buttonText: 'Şimdi Gözat 🎖️',
              buttontextstyle: GoogleFonts.comfortaa(
                color: NowUIColors.beyaz,
                fontSize: 15,
              ),
              buttonWidget: Container(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ),
              activeColor: NowUIColors.card,
              isFinished: isFinished,
              onWaitingProcess: () {
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    isFinished = true;
                  });
                });
              },
              onFinish: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: Home()));

                //TODO: For reverse ripple effect animation
                setState(() {
                  isFinished = false;
                });
              },
            ),
          )
        ],
      )),
    );
  }
}
