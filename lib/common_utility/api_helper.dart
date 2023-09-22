
import 'dart:convert';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/models/cls_delivery_break_in.dart';
import 'package:delivery/models/cls_delivery_break_off.dart';
import 'package:delivery/models/cls_delivery_in.dart';
import 'package:delivery/models/cls_delivery_off.dart';
import 'package:delivery/models/cls_vehicle_registration.dart';
import 'package:delivery/screens/profile_screen/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/profile_screen/user_profile.dart';

class ApiHelper
{
  //static const String apiUrl = 'http://orderherfood.com:8080/api';
  static const String apiUrl = 'http://10.0.2.2:8080/api';

  Future<Map<String, dynamic>> getWalletDetails(String delivery_person_code,String Password) async {
    final Map<String, dynamic> requestData = {
      'delivery_person_code': delivery_person_code,
      'password': Password,
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/get_delivery_person_wallet'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wallet details');
    }
  }
  Future<Map<String, dynamic>> LoginIntoDeliveryApp(String delivery_person_code,String Password) async {
    final Map<String, dynamic> requestData = {
      'delivery_person_code': delivery_person_code,
      'password': Password,
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/deliverypersonlogin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wallet details');
    }
  }
  Future<Map<String, dynamic>> UpdateStatusOnlineDeliveryPerson(DeliveryPersonIN _deliveryperson) async {
    final Map<String, dynamic> requestData = _deliveryperson.toJson();
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/deliveryperson_in'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print('json.decode(response.body)');
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw Exception('Failed to Login/Start The Day');
    }
  }

  void updateProfileAndNavigate(BuildContext context, cls_DeliveryPersonProfile updatedProfile,String base64Image) async {

    final Map<String, dynamic> requestData = {
      'delivery_person_code': SharedPrefsValues.deliveryPersonCode,
      'correspondence_address': updatedProfile.correspondence_address,
      'email': updatedProfile.email,
      'mobile_number': updatedProfile.mobile_number.toString(),
      'password': SharedPrefsValues.Password.toString(),
      'otp': '1234'.toString(),
      'delivery_person_photo': base64Image == null || base64Image.isEmpty ? "xxxx": base64Image ,
    };
    print(requestData);
    final postResponse = await CommonUtils.postRequest("update_profile_delivery_person",requestData);

    print(postResponse);
    if (postResponse.success) {
      final jsonResponse = json.decode(postResponse.data);
      final IsSuccess = jsonResponse['Success'];
      if (IsSuccess == 'Y') {
        AppSharedPreferences.setStringValue("Mobile", updatedProfile.mobile_number.toString());
        AppSharedPreferences.setStringValue("Email", updatedProfile.email.toString());
        AppSharedPreferences.setStringValue("Address", updatedProfile.correspondence_address.toString());
        AppSharedPreferences.setBool('isLoggedIn', true);
        if(base64Image!="")
        {
          AppSharedPreferences.setStringValue("imagePath", base64Image);
          SharedPrefsValues.imagePath=base64Image;
        }
        CommonUtils.showSnackBar(
          context,
          'Profile updated successfully.',
          backgroundColor: Colors.green,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
      } else {
        CommonUtils.showSnackBar(
          context,
          "Error in processing request",
          backgroundColor: Colors.red,
        );
      }
    }
    else {
      CommonUtils.showSnackBar(
        context,
        "API Error: ${postResponse.error}",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<Map<String, dynamic>> UpdateStatusOfflineDeliveryPerson(DeliveryPersonOUT _deliveryperson) async {
    final Map<String, dynamic> requestData = _deliveryperson.toJson();
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/deliveryperson_out'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to close the day.. please try again..');
    }
  }

  Future<Map<String, dynamic>> UpdateStatusBreakStartDeliveryPerson(DeliveryPersonBreakIN _deliveryperson) async {
    final Map<String, dynamic> requestData = _deliveryperson.toJson();
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/deliveryperson_break_start'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wallet details');
    }
  }
  static Future<Map<String, dynamic>> UpdateStatusBreakOffDeliveryPerson(DeliveryPersonBreakOUT _deliveryperson) async {
    final Map<String, dynamic> requestData = _deliveryperson.toJson();
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/deliveryperson_break_end'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load wallet details');

    }
  }
  static Future<Map<String, dynamic>> resend_OTP_Again(String mobile, String message) async {

    final Map<String, dynamic> requestData = {
      "mobile_number" :mobile,
      "message" : message
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/sendSMS'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send SMS');
    }

  }
  static Future<Map<String, dynamic>> setNewOrderStatus(String ordernumber, String status) async {

    final Map<String, dynamic> requestData = {
      "ordernumber" :ordernumber,
      "status" : status
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/setorderstatus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Status');
    }

  }

   Future<Map<String, dynamic>> OrderReceiptbyDeliveryPerson(String ordernumber, String delivery_person_code, String order_received) async {

    final Map<String, dynamic> requestData = {
      "ordernumber" :ordernumber,
      "delivery_person_code" : delivery_person_code,
      "order_received" : order_received
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/orderreceiptdeliveryperson'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Status');
    }

  }
   Future<Map<String, dynamic>> OrderPickedUpByDeliveryPerson(String ordernumber, String status) async {

    final Map<String, dynamic> requestData = {
      "ordernumber" :ordernumber,
      "status" : status
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/orderpickedupdeliveryperson'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Status');
    }

  }
   Future<Map<String, dynamic>> OrderDeliveredByDeliveryPerson(String ordernumber, String status) async {

    final Map<String, dynamic> requestData = {
      "ordernumber" :ordernumber,
      "status" : status
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/orderdelivereddeliveryperson'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update Status');
    }

  }
   Future<Map<String, dynamic>> OrderCancel(String ordernumber, String cancelled_due_to) async {

    final Map<String, dynamic> requestData = {
      "ordernumber" :ordernumber,
      "cancelled_due_to" : cancelled_due_to
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/cancel'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to cancel order');
    }

  }
  static Future<Map<String, dynamic>> GetDeliveredOrders(String deliverypersoncode) async {

    final Map<String, dynamic> requestData = {
      "deliverypersoncode" :deliverypersoncode
    };
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/getdeliveredorders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get delivered orders');
    }

  }
  static Future<Map<String, dynamic>> getDeliveryPersonOrders(String status_type, String deliveryPersonCode) async {
    try {
      final Map<String, dynamic> requestData = {
        "status_type": status_type,
        "deliverypersoncode": deliveryPersonCode,
        "deliveryperson_key": deliveryPersonCode
      };

      final response = await http.post(
        Uri.parse('$apiUrl/getdeliverypersonorders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to get delivery person orders');
      }
    } catch (e) {
      // Handle errors, e.g., logging or showing an error message
      print('Error: $e');
      throw Exception('Failed to get delivery person orders');
    }
  }

  static Future<Map<String, dynamic>> UpdateVehicleDetailsDeliveryPerson(VehicleRegistration _deliveryperson) async {
    final Map<String, dynamic> requestData = _deliveryperson.toJson();
    print(requestData);
    final response = await http.post(
      Uri.parse('$apiUrl/registerdeliverypersonvehicle'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update vehicle details');

    }
  }


}

