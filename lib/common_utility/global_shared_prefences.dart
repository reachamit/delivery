import 'dart:convert';
import 'package:flutter/src/material/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_util.dart';

class AppSharedPreferences {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setStringValue(String key, String value) async {
    await _prefs.setString(key, value);
    await fetchSharedPrefsValues(_prefs);
  }
  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
  static String getStringValue(String key) {
    return _prefs.getString(key) ?? '';
  }
  static Future<void> fetchSharedPrefsValues(prefs) async {
    SharedPrefsValues.name = prefs.getString('name') ?? '';
    SharedPrefsValues.mobile = prefs.getString('mobile') ?? '';
    SharedPrefsValues.dateOfBirth = prefs.getString('dateOfBirth') ?? '';
    SharedPrefsValues.vehicle_number = prefs.getString('vehicleNumber') ?? '';
    SharedPrefsValues.licence_number = prefs.getString('licenceNumber') ?? '';
    SharedPrefsValues.deliveryPersonCode = prefs.getString('deliveryPersonCode') ?? '';
    SharedPrefsValues.deliveryPersonKey = prefs.getString('deliveryPersonKey') ?? '';
    SharedPrefsValues.deliveryLoginStatus = prefs.getString('DeliveryLoginStatus') ?? '0';
    SharedPrefsValues.deliveryLoginStart = prefs.getString('DeliveryLoginStart') ?? '';

    SharedPrefsValues.Address = prefs.getString('Address') ?? '';
    SharedPrefsValues.imagePath = prefs.getString('imagePath') ?? '';
    SharedPrefsValues.Password = prefs.getString('Password') ?? '';
    SharedPrefsValues.otp = prefs.getString('otp') ?? '';
    SharedPrefsValues.isAccountActivated = prefs.getString('isAccountActivated') ?? 'N';

  }


}

class SharedPrefsValues {

  static String name = '';
  static String mobile = '';
  static String email = '';
  static String dateOfBirth = '';
  static String vehicle_number = '';
  static String licence_number = '';
  static String deliveryPersonCode="";
  static String deliveryPersonKey='';
  static String deliveryLoginStatus = '0';
  static String Address='';
  static String Password='';
  static String imagePath='assets/images/delivery.png';
  static String otp='#12#';
  static String isAccountActivated='N';
  static String deliveryLoginStart='';

}
