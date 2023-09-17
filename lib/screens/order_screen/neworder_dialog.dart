import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:delivery/screens/order_screen/in_progress_orders.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  final RemoteMessage? message;



  NewOrderScreen({this.data, this.message});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Order Alert"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.shade100,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Order Number: ${data?['orderNumber'] ?? 'N/A'}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Message: ${message?.notification!.body.toString() ?? 'N/A'}'), //this.message
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final Map<String, dynamic> profileDetailsMap =
                      await ApiHelper().OrderReceiptbyDeliveryPerson(data?['orderNumber'], SharedPrefsValues.deliveryPersonCode, 'Y' );
                      print(profileDetailsMap);
                      String IsSuccess = profileDetailsMap['Success']??"";
                      print(IsSuccess);
                      if (IsSuccess == 'Y') {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  OrderStatus()),(route) => false,);
                      } else {
                        String message =
                            profileDetailsMap['Data']['ErrorMessage'];
                        print(message);
                        CommonUtils.showSnackBar(context, message,
                            backgroundColor: Colors.red,
                            );
                      }
                    } catch (e) {
                      print(e);
                      CommonUtils.showSnackBar(
                          context, 'Error occurred while accepting order: $e',
                          backgroundColor: Colors.red,
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Accept',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
    ),
                ),
                SizedBox(width: 16), // Add some spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Reject',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                ),
              ],
            ),


          ],
        ),
        bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
      ),
    );
  }
}
