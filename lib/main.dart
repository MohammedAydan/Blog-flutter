import 'dart:io';

import 'package:blog_mag/my_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// const String url = 'https://lxxlwdonasqjgklfknrc.supabase.co';
// const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx4eGx3ZG9uYXNxamdrbGZrbnJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA2Nzk1MjQsImV4cCI6MjAyNjI1NTUyNH0.qgi4kr2ZZDBto4JeVZuYEiT0aEBeF666xWVK5Pu1k-g';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
  initializationForFCM();
}

void initializationForFCM() async {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  NotificationSettings settings = await fcm.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
    announcement: true,
  );
  await fcm.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  List<String> topics = ['all', 'android', 'ios', 'web'];

  // Subscribe to 'all' topic by default
  await fcm.subscribeToTopic(topics[0]);

  // Subscribe to platform-specific topics
  for (String topic in topics) {
    if (Platform.isAndroid && topic == 'android') {
      await fcm.subscribeToTopic(topic);
    } else if (Platform.isIOS && topic == 'ios') {
      await fcm.subscribeToTopic(topic);
    } else if (Platform.isMacOS && topic == 'web') {
      await fcm.subscribeToTopic(topic);
    }
  }
  FirebaseMessaging.onBackgroundMessage(_onBakgroundMessageHandler);
}

Future<void> _onBakgroundMessageHandler(RemoteMessage message) async {
  print('onBackgroundMessage: $message');
  return;
}
