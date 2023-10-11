import 'package:clean_dialog/clean_dialog.dart';
import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:delivery/screens/order_screen/in_progress_orders.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  final RemoteMessage? message;
  NewOrderScreen({this.data, this.message});
  GoogleMapController? _mapController;
  final LatLng currentLocation = LatLng(37.7756, -122.4194);
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false; // Allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Order Alert!!"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.shade100,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CleanDialog(
              title: 'New Order Received!!',
              content: 'Confirm your order?\n',
              backgroundColor: Colors.red,
              titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
              actions: [
                CleanDialogActionButtons(
                  actionTitle: 'Order Number: ${data?['orderNumber'] ?? 'N/A'}',
                  textColor: Colors.black45,
                  onPressed: ()  {},
                ),
                CleanDialogActionButtons(
                  actionTitle: '${message?.notification!.body.toString() ?? 'N/A'}',
                  textColor: Colors.black45,
                  onPressed: ()  {},
                ),
                // CleanDialogActionButtons(
                //   actionTitle: ' ORDER',
                //   textColor: const Color(0XFF27ae61),
                //   onPressed: ()  {
                //
                //   },
                // ),
                // CleanDialogActionButtons(
                //   actionTitle: 'REJECT ORDER',
                //   onPressed: () => Navigator.pop(context),
                //
                // ),
              ],
            ),

    Expanded(
    child: GoogleMap(
    initialCameraPosition: CameraPosition(
    target: LatLng(37.7749, -122.4194), // Replace with your desired initial map position
    zoom: 14.0, // Adjust the initial zoom level
    ),
    markers: Set<Marker>.from([
    Marker(
    markerId: MarkerId('marker_1'),
    position: LatLng(37.7749, -122.4194), // Replace with the marker's position
    infoWindow: InfoWindow(
    title: 'Kitchen location',
    snippet: 'Marker Snippet',
    ),
    ),
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(37.7749, -122.4100), // Replace with the marker's position
        infoWindow: InfoWindow(
          title: 'Customer Location',
          snippet: 'Marker Snippet',
        ),
      ),
      Marker(
        markerId: MarkerId('marker_3'),
        position: currentLocation,
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'Marker Snippet',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Customize marker appearance
      ),
    ]),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      myLocationEnabled: true, // Enable the "My Location" button
      myLocationButtonEnabled: true,
    ),
    ),
            SizedBox(height: 20),
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
                  child: Text('ACCEPT',
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
                  child: Text('REJECT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
        bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
      ),
    );
  }
}
