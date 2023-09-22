import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/order_screen/delievered_orders_screen.dart';
import 'package:delivery/screens/order_screen/in_progress_orders.dart';
import 'package:delivery/screens/order_screen/order_status_screen.dart';
import 'package:delivery/screens/profile_screen/user_profile.dart';
import 'package:delivery/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attandance.dart';
import 'faq.dart';
import 'order_screen/google_map_customer_roadmap.dart';
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
        padding: const EdgeInsets.only(top: 80),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SharedPrefsValues.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      SharedPrefsValues.deliveryPersonCode,
                      style: const TextStyle(
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

          // ListTile(
          //     leading: Icon(Icons.home),
          //     title: Text('Vehicle Registration'),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => VehicleRegistrationForm()),
          //       );
          //     }),
           const Divider(),
          ListTile(
            leading: const Icon(Icons.person_2, color: Colors.orange),
            title: const Text('Profile'),
            subtitle: const Text(
              'View your profile details',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.login, color: Colors.blue),
              title: const Text('Attandance'),
              subtitle: const Text(
                'Mark your Attandance',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Attandance()),
                );
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.reorder_sharp, color: Colors.blue),
              title: const Text('In Progress Orders'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderStatus()),
                );
              }),

          const Divider(),
          ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Wallet'),
              subtitle: const Text(
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
                      builder: (context) => const DeliveryPersonWallet()),
                );
              }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.question_answer_rounded, color: Colors.green),
            title: const Text('FAQs'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FaqPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.question_answer_rounded, color: Colors.green),
            title: const Text('Vehicle Registration'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => VehicleRegistrationForm()));
            },
          ),

          const Divider(),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const SignIn()),(Route<dynamic> route) => false );
            },
          ),
        ],
      ),
    );
  }
}
