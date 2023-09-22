import 'package:delivery/screens/vehicle_details_screen/vehicle_details.dart';
import 'package:flutter/material.dart';

import 'profile_screen/edit_profile.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              // Navigate to the change password screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Update Profile'),
            onTap: () {
              // Navigate to the update profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Update Vehicle Registration'),
            onTap: () {
              // Navigate to the update vehicle registration screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleRegistrationForm(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Text('Change password screen content'),
      ),
    );
  }
}


