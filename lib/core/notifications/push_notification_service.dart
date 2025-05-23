import 'dart:convert';

import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {
  static late FirebaseMessaging messaging;
  static late String deviceToken;
  static late String accessToken;

  static Future<void> init() async {
    messaging = FirebaseMessaging.instance;

    //request permission of device (enabled by default in android)
    await messaging.requestPermission();
    getDeviceToken();
    FirebaseMessaging.onMessage.listen(handleMessageInForeground);
    getAccessToken();
    // subscribeToTopic();
  }

  //get Token of Device
  static Future<void> getDeviceToken() async {
    String token = await messaging.getToken() ?? 'null';
    deviceToken = token;
    debugPrint("************ Token ******************");
    debugPrint("************ $token ******************");
    debugPrint("************ Token ******************");
  }

  //handle notificaiton in foreground
  static void handleMessageInForeground(RemoteMessage message) {
    debugPrint("************ Handling a Foreground message ******************");
    debugPrint("************ ${message.notification!.body} ******************");
    debugPrint("************ Handling a Foreground message ******************");
  }

  //get Access key of app
  static Future<void> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "we-chat-a0044",
      "private_key_id": "8c1529b90604f4e1c096a32f58dcfabd07d14282",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8CaQzu/gXVcT3\ndXDXlqnC/S/UmJDNCNtkKanSpXiUKJXOkyZWjHieCf3pIMMAix5KA6SATY+g9Vo4\nex90IOmDupvmR/xvGia8vvu8pTEkkX1qZkNS8VzJEpLYa9RM67lEE+TDDwIA4KD/\nYouM3utpC+Qf6pc3qWYLRaTWVDaWTk48TYYq0AdEkdqzuaYmeR9zymEKswF8uJV8\n9ExGvdzcz6SjH4ITTB20uWXnYIx6KAAPu5BUb8CZS11J0wk+2OEYsb+3mOdd93SW\njyMn9nhT1HLFAsb5ghvp9NAJ59R6K0TP5Ava/HPtph9LoTiwlsFg2ZdlcTQ4HnBl\nlAefHzFdAgMBAAECggEABFCU/So/3UqMDFZHDRi5c4PQyv2R5l/g0jxnLQdmrBZU\nUwWrDbWyd4STgtEheGE42YpE25GBYrhOkNjjwLaX9ScH4xxdbVqPGf9TPSHDQ2ti\nkoRJ4NzbUV0vk8TBqImI2kg56cSYj1btitQC5MF2wGspRGw4emqqMJxcAHO1PvSp\n7ae7XCHLe7GQjXR6ccxLEf1zBuWFQonywdT7fp3jG7jFrPhgVKxXrEuXkU0Zqdkl\njBqljIP3vt3P2ndvBYAL9Gn3QyBejoiNFs+YAJQMysbrPAn10qZfQS0Y85nOme0p\nARf2hloroOG+WaYfEbi5SWS5di4c6cI8wHTaV8qMtwKBgQDwL/MJQPXINxwBenC9\nXV57RxhxPgJcpATFpaKeO7X/jTNVbFHmJKrymmA+ZJN47+MJapaAmgKSqN/JN5Xw\nZqD8h7PaXPTwiBn4STGvqBVVaQILJtw0+R5rdggOS7RhOmH8rgMoQX4VapKU3ked\nyVkdlLVdfr65xfFHsHIovxr/owKBgQDIasbAsFg5+djhpZqGLKYrJf72sRq6dK8q\nTMQ38TQ6cADZQlA17TW4vZVpS5bOjF9zx4bj5PQD5Eut5igTUsYD+xaFaa7/gWIw\nSfUoy5hiai0NFxEsTDkIvPN1jxaBOaRL61pqDqo1BfpV2AiJpslexuQLjsKFXNft\njCU5aewa/wKBgQDIlKJ31eHro+olaeUAnxqqBMNqvogmaWr6y8o0LlVc5sQ50E3M\nzk5cb4N0V3W4h0yornSlTPhdFd5dIah7rJlAiustrnd275IQgL+Xm9zFCP6F5Zv8\nORaoU1eC6MHoeGMgKwnD8n2i0O88lyxjnqRnSar0O0Z3ydAnODj9wip/1QKBgQCi\nmdbE8I20A9wNPqF+6GyspzgTh57q1c5j4EJ2LLC2FLbrjZysE9c5Gj9FXXlt/H9Y\n3PG4pcHAApHP9eJfwxE6m5UrCpJbY+p4yRgpT/1DI2eHrkZVjUXcrAhOQZf9ofmF\nSt5hG6LGQCJZUVuj6niH949/PQTe1HOvm7t7uE9BmwKBgGIsCpeBnme01uxH0dAD\nc0a3KLrEKhlJQAk3AqpxjIG5hw9RRALpc1qGZmbq+ClkddKByuv2dO6t4oZy6gz0\nOhwVWam8jyA6qkjUdPhdxg4Z9DbGXTq5cJQlnHDHUVQ6yc38opoFprkmGOtfbPV1\nLxtoTFpmzWQUSS5O2rJQ4Psp\n-----END PRIVATE KEY-----\n",
      "client_email": "chat-233@we-chat-a0044.iam.gserviceaccount.com",
      "client_id": "115185477289757318070",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/chat-233%40we-chat-a0044.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials = await auth
        .obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client,
        );
    client.close();
    accessToken = credentials.accessToken.data;
    debugPrint("************ Access Token ******************");
    debugPrint(
      "************ ${credentials.accessToken.data} ******************",
    );
    debugPrint("************ Access Token ******************");
  }

  //send notification from device
  static Future<dynamic> sendNotification({
    required String title,
    required String body,
    required String deviceToken,
  }) async {
    final Map<String, dynamic> message = {
      FireBaseConstants.messageKey: {
        FireBaseConstants.token: deviceToken,
        FireBaseConstants.notification: {
          FireBaseConstants.title: title,
          FireBaseConstants.body: body,
        },
        FireBaseConstants.data: {"route": "Any Thing"},
      },
    };
    final http.Response response = await http.post(
      Uri.parse(FireBaseConstants.fcmUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully');
    } else {
      debugPrint('Failed to send notification');
    }
  }

  //subscribe with topic
  static Future<void> subscribeToTopic() async {
    await messaging.subscribeToTopic('users');
  }

  //Unsubscribe with topic
  static Future<void> unSubscribeToTopic() async {
    await messaging.unsubscribeFromTopic('users');
  }
}

//handle notificaiton in background and trminated
@pragma('vm:entry-point')
Future<void> handleMessageInBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("************ Handling a background message ******************");
  debugPrint("************ ${message.notification!.body} ******************");
  debugPrint("************ Handling a background message ******************");
}
