import 'dart:async';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/main.dart';
import 'package:delivery/models/cls_delivery_break_in.dart';
import 'package:delivery/models/cls_delivery_break_off.dart';
import 'package:delivery/models/cls_delivery_in.dart';
import 'package:delivery/models/cls_delivery_off.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:delivery/screens/order_screen/google_map_customer_roadmap.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:delivery/screens/profile_screen/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navbar.dart';
import 'profile_screen/edit_profile.dart';
import 'settings_screen.dart';
import 'package:badges/badges.dart' as badges;

class Attandance extends StatefulWidget {
  const Attandance({Key? key}) : super(key: key);

  @override
  _AttandanceState createState() => _AttandanceState();
}

class _AttandanceState extends State<Attandance> {
  bool loginState = SharedPrefsValues.deliveryLoginStatus=="1"?true:false;

  bool applyBreak = false;
  String formatTime(DateTime time) {
    return DateFormat('hh:mm:ss a').format(time);
  }

  DateTime? loginStartTime;
  DateTime? loginEndTime;

  List<List<String>> _items = [
    ['-', 'Start Time'],
    ['-', 'End Time'],
    ['-', 'Time Difference'],
  ];



  void calculateTimeDifference() {
    if (loginStartTime != null && loginEndTime != null) {
      final difference = loginEndTime!.difference(loginStartTime!);
      _items[0][0] = formatTime(loginStartTime!);
      _items[1][0] = formatTime(loginEndTime!);
      _items[2][0] ='${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    } else {
      _items[2][0] = '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = loginState ? Colors.redAccent : Colors.lightGreen;
    final textColor = loginState ? Colors.black : Colors.white;

    bool isBreakTime = loginState && applyBreak;
    if(loginState)
    {
      String _loginStartTime = SharedPrefsValues.deliveryLoginStart;
      if(_loginStartTime!="")
        {
          _items[0][0]=_loginStartTime;
          _items[1][0] ='-';
          final format = DateFormat('hh:mm:ss a');
          final parsedTime = format.parse(_loginStartTime);
          final now = DateTime.now();
          loginStartTime = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute, parsedTime.second);
          print('loginStartTime');
          print(loginStartTime);
        }
    }
    // else
    //   {
    //     _items[0][0] ='-';
    //     _items[1][0] ='-';
    //   }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        //title: Text('Mark Your Presence'),
        title: Text(
          SharedPrefsValues.deliveryPersonCode,
          style:  TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
        centerTitle: true,
       // backgroundColor: backgroundColor,
        actions: <Widget>[

      Padding(
      padding: const EdgeInsets.all(8.0),
      child: loginState
          ? const Row(
        children: [
          Icon(
            Icons.circle,
            color: Colors.green,
            size: 14,
          ),
          SizedBox(width: 8),
          Text(
            "Online",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
          : const Row(
        children: [
          Icon(
            Icons.circle,
            color: Colors.black,
            size: 12,
          ),
          SizedBox(width: 8),
          Text(
            "Offline",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),

          badges.Badge(
          
            onTap: () {},
            position: badges.BadgePosition.topEnd(top: -8, end: 8),
            showBadge: true,//notificationCount > 0,
            ignorePointer: false,
            badgeContent: Text(
              notificationCount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
            icon:Icon(Icons.notifications),
            onPressed: () {
              setState(() {
                notificationCount = 0;
              });
            },
          ),
          )
        ],
      ),
      drawer: const NavBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CommonUtils
                            .loadImageAssetOrDefault(), // Provide the asset path
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Container(
                        margin: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: loginState
                              ? (isBreakTime ? Colors.orange : Colors.green)
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                SharedPrefsValues.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                //title: const Text("Login/Start your Day:"),
                title: ElevatedButton(
                  onPressed: () async {
                    if (loginState) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                           return CleanDialog(
                             title: '',
                             content: 'Are you sure you want to go offline?',
                             backgroundColor: const Color(0XFFbe3a2c),
                             titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                             contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
                             actions: [
                               CleanDialogActionButtons(
                                 actionTitle: 'Cancel',
                                 onPressed: () => Navigator.pop(context),
                               ),
                               CleanDialogActionButtons(
                                 actionTitle: 'OK',
                                 textColor: const Color(0XFF27ae61),
                                 onPressed: () async {
                                           var result =
                                           await updateDeliveryLogoutStatus(context);
                                           setState(() {
                                             print('logout process');
                                             print(result);
                                             if (result == 'Y') {
                                               loginState = false;
                                               loginEndTime = DateTime.now();
                                               _items[0][0] = formatTime(loginStartTime!);
                                               _items[1][0] = formatTime(loginEndTime!); //loginEndTime.toString();
                                               applyBreak = false;
                                               calculateTimeDifference();
                                               AppSharedPreferences.setStringValue("DeliveryLoginStatus", "0");
                                               AppSharedPreferences.setStringValue("DeliveryLoginStart", "");
                                             }
                                           });
                                           Navigator.of(context).pop(); // Close the dialog
                                           AppSharedPreferences.setStringValue("DeliveryLoginStatus", "0");
                                           AppSharedPreferences.setStringValue("DeliveryLoginStart", "");
                                 },
                               ),
                             ],
                           );
                          // return AlertDialog(
                          //   title: Text("Confirmation"),
                          //   content:
                          //   Text("Are you sure you want to go offline?"),
                          //   actions: [
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.of(context)
                          //             .pop(); // Close the dialog
                          //       },
                          //       child: Text("Cancel"),
                          //     ),
                          //     TextButton(
                          //       onPressed: () async {
                          //         var result =
                          //         await updateDeliveryLogoutStatus(context);
                          //         setState(() {
                          //           print('logout process');
                          //           print(result);
                          //           if (result == 'Y') {
                          //             loginState = false;
                          //             loginEndTime = DateTime.now();
                          //             _items[0][0] = formatTime(loginStartTime!);
                          //             _items[1][0] = formatTime(loginEndTime!); //loginEndTime.toString();
                          //             applyBreak = false;
                          //             calculateTimeDifference();
                          //             AppSharedPreferences.setStringValue("DeliveryLoginStatus", "0");
                          //             AppSharedPreferences.setStringValue("DeliveryLoginStart", "");
                          //           }
                          //         });
                          //
                          //         Navigator.of(context).pop(); // Close the dialog
                          //         AppSharedPreferences.setStringValue("DeliveryLoginStatus", "0");
                          //         AppSharedPreferences.setStringValue("DeliveryLoginStart", "");
                          //       },
                          //       child: Text("Turn Off"),
                          //     ),
                          //   ],
                          // );
                        },
                      );
                    } else {
                      var result = await updateDeliveryLoginStatus(context);
                      print('result');
                      print(result);
                      setState(() {
                        if (result == 'Y') {
                          loginState = true;
                          applyBreak = false; // Turn off break time
                          loginStartTime = DateTime.now();
                          _items[0][0] = formatTime(loginStartTime!);
                          //_items[1][0] = '-';
                          //_items[2][0] = '-';
                          AppSharedPreferences.setStringValue("DeliveryLoginStatus", "1");
                          AppSharedPreferences.setStringValue("DeliveryLoginStart", formatTime(loginStartTime!));
                        }
                      });
                    }
                    // // Update time difference
                    // if (loginStartTime != null && loginEndTime != null) {
                    //   final difference = loginEndTime!.difference(loginStartTime!);
                    //   _items[2][0] = '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
                    // } else {
                    //   _items[2][0] = '-';
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: applyBreak
                        ? Colors.red
                        : (loginState ? Colors.green : Colors.white12),
                  ),
                  child: Text(
                    loginState
                        ? 'Click to go Offine'
                        : 'Start Your Day - Go Online!!',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ),

              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _items.map((item) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          item[1],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                      Text(
                        item[0],
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  );
                }).toList(),
              ),
              const Divider(),
              Container(
                padding: EdgeInsets.all(50.0),
                width: MediaQuery.of(context).size.width-10,
                height:200,
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //       begin: Alignment.bottomCenter,
                    //       end: Alignment.topCenter,
                    //       colors: [Color(0xff0043ba), Color(0xff006df1)]),
                  // color: Colors.red,
                  borderRadius:BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )
                ),
                  child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                    children: [

                    ],
                )
              )
            ],
          ),

        ],
      ),
      bottomNavigationBar:SafeArea(

        child: Container(

        padding: EdgeInsets.all(12),
          margin:EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color:Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(24))
          ),
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              SizedBox(
                  height:36,
                  width:36,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Attandance(),
                    ),
                  );
                },
                child: RiveAnimation.asset(
                  "assets/animated-icon-set.riv",
                  artboard: "HOME",
                ),
              ),
             ),
              SizedBox(
                height:36,
                width:36,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                    );
                  },
                  child: RiveAnimation.asset(
                    "assets/animated-icon-set.riv",
                    artboard: "USER",
                  ),
                ),
              ),
              // SizedBox(
              //   height:36,
              //   width:36,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => OrderStatus(),
              //         ),
              //       );
              //     },
              //     child: RiveAnimation.asset(
              //       "assets/animated-icon-set.riv",
              //       artboard: "SEARCH",
              //     ),
              //   ),
              // ),
              SizedBox(
                height:36,
                width:36,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderStatus(),
                      ),
                    );
                  },
                  child: RiveAnimation.asset(
                    "assets/animated-icon-set.riv",
                    artboard: "BELL",
                  ),
                ),
              ),
              SizedBox(
                height:36,
                width:36,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  child: RiveAnimation.asset(
                    "assets/animated-icon-set.riv",
                    artboard: "SETTINGS",
                  ),
                ),
              ),
            ]
          )
      ),
      ),
      bottomSheet: SharedPrefsValues.isAccountActivated == 'Y'
          ? null
          : BottomSheetWidget(),
    );
  }
}

class SwitchExample extends StatefulWidget {
  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool day_start = false;
  bool day_close = false;
  bool break_on = false;
  bool break_off = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text(
              "Login/Start your Day: ${day_start ? 'ON' : 'OFF'}",
              style: TextStyle(
                color: break_on
                    ? Colors.blue
                    : (day_start ? Colors.green : Colors.red),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Switch(
              thumbIcon: thumbIcon,
              value: day_start,
              onChanged: (bool value) {
                setState(() {
                  day_start = value;
                  String DeliveryLoginStatus = value ? "1" : "0";
                  AppSharedPreferences.setStringValue("DeliveryLoginStatus", DeliveryLoginStatus);
                  if (!value) {
                    break_on = false;
                    break_off = false;
                  }
                });
              },
            ),
          ],
        ),
        Visibility(
          visible: day_start,
          child: Row(
            children: [
              Text(
                "Apply Break Time: ${break_on ? 'ON' : 'OFF'}",
                style: TextStyle(
                  color: break_on ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                thumbIcon: thumbIcon,
                value: break_on,
                onChanged: (bool value) {
                  setState(() {
                    break_on = value;
                    AppSharedPreferences.setStringValue("DeliveryLoginStatus", value ? "2" : "1");
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future<String> updateDeliveryLoginStatus(BuildContext context) async {
  var isSuccess = 'N';
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // User denied permission, show explanation and guide to settings
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Denied"),
          content: Text(
              "To use this feature, please enable location permissions in your device settings."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                // Open app settings
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return isSuccess;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    DeliveryPersonIN deliveryPerson = DeliveryPersonIN(
      delivery_person_code: SharedPrefsValues.deliveryPersonCode.toString(),
      delivery_person_name: SharedPrefsValues.name.toString(),
      in_date_time: formattedDate.toString(),
      current_latitude: position.latitude,
      current_longitude: position.longitude,
      password: SharedPrefsValues.Password.toString(),
    );
    final Map<String, dynamic> deliveryPersonINMap =
        await ApiHelper().UpdateStatusOnlineDeliveryPerson(deliveryPerson);
    isSuccess = deliveryPersonINMap['Success'];
    return isSuccess; //'Y' or 'N'
  } catch (e) {
    print('Error while start your day: $e');
    return isSuccess;
  }
}

Future<String> updateDeliveryLogoutStatus(BuildContext context) async {
  var isSuccess = 'N';
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // User denied permission, show explanation and guide to settings
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Denied"),
          content: Text(
              "To use this feature, please enable location permissions in your device settings."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                // Open app settings
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return isSuccess;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    DeliveryPersonOUT deliveryPerson = DeliveryPersonOUT(
      delivery_person_code: SharedPrefsValues.deliveryPersonCode.toString(),
      delivery_person_name: SharedPrefsValues.name.toString(),
      out_date_time: formattedDate.toString(),
      current_latitude: position.latitude,
      current_longitude: position.longitude,
      password: SharedPrefsValues.Password.toString(),
    );
    final Map<String, dynamic> deliveryPersonINMap =
        await ApiHelper().UpdateStatusOfflineDeliveryPerson(deliveryPerson);
    isSuccess = deliveryPersonINMap['Success'];
    return isSuccess; //'Y' or 'N'
  } catch (e) {
    print('Error while closing your day: $e');
    return isSuccess;
  }
}

Future<String> updateDeliveryBreakINStatus(BuildContext context) async {
  var isSuccess = 'N';
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // User denied permission, show explanation and guide to settings
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Denied"),
          content: Text(
              "To use this feature, please enable location permissions in your device settings."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                // Open app settings
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return isSuccess;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    DeliveryPersonBreakIN deliveryPerson = DeliveryPersonBreakIN(
      delivery_person_code: SharedPrefsValues.deliveryPersonCode.toString(),
      delivery_person_name: SharedPrefsValues.name.toString(),
      break_start_date_time: formattedDate.toString(),
      current_latitude: position.latitude,
      current_longitude: position.longitude,
      password: SharedPrefsValues.Password.toString(),
    );
    final Map<String, dynamic> deliveryPersonINMap =
        await ApiHelper().UpdateStatusBreakStartDeliveryPerson(deliveryPerson);
    isSuccess = deliveryPersonINMap['Success'];
    return isSuccess; //'Y' or 'N'
  } catch (e) {
    print('Error while closing your day: $e');
    return isSuccess;
  }
}

Future<String> updateDeliveryBreakOUTStatus(BuildContext context) async {
  var isSuccess = 'N';
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // User denied permission, show explanation and guide to settings
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Denied"),
          content: Text(
              "To use this feature, please enable location permissions in your device settings."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                // Open app settings
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return isSuccess;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    DeliveryPersonBreakOUT deliveryPerson = DeliveryPersonBreakOUT(
      delivery_person_code: SharedPrefsValues.deliveryPersonCode.toString(),
      delivery_person_name: SharedPrefsValues.name.toString(),
      break_end_date_time: formattedDate.toString(),
      current_latitude: position.latitude,
      current_longitude: position.longitude,
      password: SharedPrefsValues.Password.toString(),
    );
    final Map<String, dynamic> deliveryPersonINMap =
        await ApiHelper.UpdateStatusBreakOffDeliveryPerson(deliveryPerson);
    isSuccess = deliveryPersonINMap['Success'];
    return isSuccess; //'Y' or 'N'
  } catch (e) {
    print('Error while closing your day: $e');
    return isSuccess;
  }
}
