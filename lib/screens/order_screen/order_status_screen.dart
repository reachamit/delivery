import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:delivery/screens/order_screen/google_map_customer_roadmap.dart';
import 'package:flutter/material.dart';
import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/models/cls_order_detail.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class OrderStatus extends StatefulWidget {
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Status'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can change the icon as needed
          onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Attandance()),
          );
          },
          ),
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Received', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
                Tab(child: Text('Order Picked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
                Tab(child: Text('Delivered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
              ],
            )
        ),
        body: TabBarView(
          children: [
            OrderList(status: 'OrderReceived'),
            OrderList(status: 'OrderPicked'),
            OrderList(status: 'Delivered'),
          ],
        ),
        bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
      ),
    );
  }
}


class OrderList extends StatefulWidget {
  final String status;
  OrderList({required this.status});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrderDetail> _orders = [];
  late GoogleMapController mapController;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future<void> fetchOrderDetails() async {
    try {
      String required_status = widget.status=="Delivered"?"D": widget.status=="OrderPicked"?"P":"R";
      final Map<String, dynamic> response = await ApiHelper.getDeliveryPersonOrders(required_status,SharedPrefsValues.deliveryPersonCode);
      print(response);
      final isSuccess = response['Success'];
      if (isSuccess == 'Y') {
        setState(() {
          final Map<String, dynamic> data = response['Data'];
          if (data == null || data is! Map<String, dynamic>) {
            throw Exception('Invalid response data format');
          }
          final OrderDetail order = OrderDetail.fromJson(data);
          _orders.add(order);
        });
      }
    } catch (e) {
      // Handle errors, e.g., log the error or show an error message to the user
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    final filteredOrders = _orders.toList();
    // orders.where((order) => order.status == widget.status).toList();
    DateTime? orderDateTime = filteredOrders.firstOrNull?.dateTime;
    DateTime dateTimeToFormat = orderDateTime ?? DateTime.now();
    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return Card(
          color: Colors.cyan[50],
          child: ListTile(
            title: Text('Order #${order.orderNumber}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('dd/MM/yyyy hh:mm a').format(dateTimeToFormat), style: TextStyle(fontSize: 12.0)),
                Text('Name: ${order.customername}'),
                Text('Mobile: ${order.orderNumber}'),
                Text('Email: ${order.customeremail}'),
                Text('Delivery Address: ${order.deliveryAddress}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                if (order.pickedUp == 'Y' )// && order.delivered != 'Y')
                  GestureDetector(
                    onTap: () async {
                      print('Mark Order Delivered');
                      if (order.pickedUp == 'Y') {
                        final Map<String, dynamic> profileDetailsMap = await ApiHelper().OrderDeliveredByDeliveryPerson(
                          order.orderNumber ?? '',
                          'D',
                        );
                        print(profileDetailsMap);
                        String IsSuccess = profileDetailsMap['Success'] ?? '';
                        print(IsSuccess);
                        if (IsSuccess == 'Y') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderStatus(),
                            ),
                                (route) => false,
                          );
                        } else {
                          String message = profileDetailsMap['Data']['ErrorMessage'];
                          print(message);
                          // ignore: use_build_context_synchronously
                          CommonUtils.showSnackBar(
                            context,
                            message,
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Mark Order Delivered',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMap_CustomerLocations(order: order),
                      ),
                    );
                    //showLocationMapforOrderDialog(context, order);

                  },
                  child: Text('Show Map'),
                ),
              ],
            ),
            trailing: Column(
              children: [
                Text(
                  'Rs. ${order.billAmount}',
                  style: TextStyle(
                    fontSize: 18.0, // Increase the font size
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                Text('Delivery: Rs. ${order.deliveryCharges}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 100.0, // Adjust as needed
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Customize text color
              ),
            ),
          ),
          SizedBox(width: 10.0), // Add spacing between label and value
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void showLocationMapforOrderDialog(BuildContext context, OrderDetail order) {
    final TextEditingController reasonController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Show Map'),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Order Details:'),
                Text('Order #${order.orderNumber}'),
                SizedBox(height: 16), // Add some spacing
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(order.delivery_latitude??0, order.delivery_latitude??0),
                    zoom: 15.0,
                  ),
                  markers: <Marker>[
                    Marker(
                      markerId: MarkerId('current_location'),
                      position: LatLng(order.delivery_latitude??0, order.delivery_latitude??0),
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  ].toSet(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String reason = reasonController.text;


                  //Navigator.of(context).pop();
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
//-----
  }

}