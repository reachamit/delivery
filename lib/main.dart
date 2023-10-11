import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:delivery/models/recieve_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_utility/global_shared_prefences.dart';
import 'firebase_options.dart';

import 'screens/attandance.dart';
import 'screens/onboard_screen/onboarding_screen.dart';
import 'screens/order_screen/neworder_dialog.dart';
import 'screens/sign_in.dart';
import 'dart:convert';

//validate here

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var notificationCount = 0;
bool loginState = SharedPrefsValues.deliveryLoginStatus=="1"?true:false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  final bytes = utf8.encode(fcmToken.toString());
  final base64Str = base64.encode(bytes);
  print('fcmToken:' + fcmToken.toString());
  print('fcmToken_base64Str:' + base64Str);
  //await FirebaseMessaging.instance.subscribeToTopic("OrderHerFoodDelivery");
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await AppSharedPreferences.init();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if(isLoggedIn)
    await AppSharedPreferences.fetchSharedPrefsValues(prefs);
  runApp(MyApp(isLoggedIn: isLoggedIn));
}
Future<void> _handleForegroundMessage(RemoteMessage message) async {
  notificationCount++;
  print('onMessage');
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print('Message data: ${message.data}');

  // final messagePayload = message.data;
  // if (messagePayload['type'] == 'new_message') {
  //   showNotification(messagePayload['message']);
  // } else if (messagePayload['type'] == 'event_reminder') {
  //   showNotification(messagePayload['event_name']);
  // }

  try {
    NotificationService().showNotification(
        title: message.notification!.title.toString(),
        body: message.notification!.body.toString(),
        payLoad: message.data);
  } catch (e) {
    print('Error showing notification: $e');
  }

  print(navigatorKey.currentState);
  if (message.data["type"] == "neworder") {
      //playAssetMP3();
    navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => NewOrderScreen(
            data: message.data,
            message: message,
          ),
        )
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  notificationCount++;

  // Handle background message here
  print("Handling background message: ${message.notification!.title}, ${message.notification!.body}, ${message.data}");
  print(navigatorKey.currentState);
  if (message.data["type"] == "neworder") {
    //playAssetMP3();
        navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => NewOrderScreen(
            data: message.data,
            message: message,
          ),
        )
    );
  }


}
class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isLoggedIn);
    print(SharedPrefsValues.name);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Order Her Food-Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: widget.isLoggedIn && SharedPrefsValues.name !='' ?"attandance":"signin",
      routes: {
        "/": (context) => OnboardingScreen(),
        "signin": (context) => const SignIn(),
        "attandance": (context) =>  const Attandance(),
        "neworder": (context) =>  NewOrderScreen(),
      },
    );
  }
}





