import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/order_screen/delievered_orders_screen.dart';
import 'package:delivery/screens/order_screen/in_progress_orders.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:delivery/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attandance.dart';
import 'faq.dart';
import 'order_screen/google_map_customer_roadmap.dart';
import 'profile_screen/profile.dart';
import 'vehicle_details_screen/vehicle_details.dart';
import 'wallet.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 80),
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        image: CommonUtils.loadImageAssetOrDefault(),
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SharedPrefsValues.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        SharedPrefsValues.deliveryPersonCode,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ListTile(
          //     leading: Icon(Icons.home),
          //     title: Text('Home'),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Attandance()),
          //       );
          //     }),
           Divider(),
          ListTile(
            leading: Icon(Icons.person_2, color: Colors.orange),
            title: Text('Profile'),
            subtitle: Text(
              'View your profile details',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.login, color: Colors.blue),
              title: Text('Attandance'),
              subtitle: Text(
                'Mark your Attandance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Attandance()),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.reorder_sharp, color: Colors.blue),
              title: Text('In Progress Orders'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderStatus()),
                );
              }),

          Divider(),
          ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              subtitle: Text(
                'My Wallet Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeliveryPersonWallet()),
                );
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.question_answer_rounded, color: Colors.green),
            title: Text('FAQs'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FaqPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.question_answer_rounded, color: Colors.green),
            title: Text('Vehicle Registration'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => VehicleRegistrationForm()));
            },
          ),

          Divider(),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => SignIn()),(Route<dynamic> route) => false );
            },
          ),
        ],
      ),
    );
  }
}
