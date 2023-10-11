import 'dart:convert';
import 'dart:typed_data';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/models/cls_ApiResponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'api_helper.dart';

class CommonUtils {
  static  const baseUrl=ApiHelper.apiUrl;
  static  Future<String?>  retrieveAndPrintFCMToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    return token;
  }


  static Future<ApiResponse> get(String endpoint) async {

    final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
    if (response.statusCode == 200) {
      return ApiResponse(success: true, data: response.body);
    } else {
      return ApiResponse(success: false, error: "Request failed with status code ${response.statusCode}");
    }
  }

  static Future<ApiResponse> postRequest(String endpoint, Map<String, dynamic> data) async {
    final postData = json.encode(data); // Convert data to JSON format
    print(postData);
    print("$baseUrl/$endpoint");
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {"Content-Type": "application/json"}, // Set the Content-Type header
      body: postData,
    );
    print(response);
    print(response.body);
    if (response.statusCode == 200) {
      return ApiResponse(success: true, data: response.body);
    } else {
      return ApiResponse(success: false, error: "Request failed with status code ${response.statusCode}");
    }
  }



  static ImageProvider<Object> loadImageAssetOrDefault() {
    try {
      if (SharedPrefsValues.imagePath.isEmpty)
      {
        return AssetImage("assets/images/default_profile.jpg");
      }
      else
      {
        Uint8List imageData = base64Decode(SharedPrefsValues.imagePath!);
        return MemoryImage(imageData);
      }
      // String assetPath = SharedPrefsValues.imagePath;
      // return AssetImage(assetPath);
    } catch (e) {
      print("Asset not found: $e");
      return AssetImage("assets/images/default_profile.jpg"); // Replace with your default image path
    }
  }



  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }



}
