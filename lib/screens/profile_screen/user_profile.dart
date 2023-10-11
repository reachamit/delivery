import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/navbar.dart';
import 'package:delivery/screens/profile_screen/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can change the icon as needed
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attandance()),
            );
          },
        ),
        title: Center(
          child: const Text('Partner Profile'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add logic for notifications
            },
          ),
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => Attandance()));
              },

            ),

          ],
        ),
        bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
       // drawer: NavBar(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red.shade300,
                        minRadius: 35.0,
                        child: Icon(
                          Icons.call,
                          size: 30.0,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 70.0,
                        child: CircleAvatar(
                          radius: 65.0,
                          backgroundImage:CommonUtils.loadImageAssetOrDefault()
                          //NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red.shade300,
                        minRadius: 35.0,
                        child: Icon(
                          Icons.message,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    SharedPrefsValues.name.toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    //width: double.infinity, // Set the container to take up all available width
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the contents horizontally
                        children: [
                          Text(
                            SharedPrefsValues.mobile != null && SharedPrefsValues.mobile.isNotEmpty
                                ? '(+91 ' + SharedPrefsValues.mobile + ')'
                                : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 8), // Add some space between the text and the badge
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Customize the badge background color
                              borderRadius: BorderRadius.circular(4), // Customize the badge shape
                            ),
                            child: Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 13, // Customize the badge text size
                                color: Colors.white, // Customize the badge text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: ListTile(
                        title: Text(
                          SharedPrefsValues.user_gender != null && SharedPrefsValues.user_gender.isNotEmpty
                              ? SharedPrefsValues.user_gender
                              : 'MALE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Gender',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: ListTile(
                        title: Text(
                          SharedPrefsValues.dateOfBirth != null && SharedPrefsValues.dateOfBirth.isNotEmpty
                              ? SharedPrefsValues.dateOfBirth
                              : '26/10/1991',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Date Of Birth',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: ListTile(
                        title: Text(
                          '5000',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Following',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  //   title: Text(
                  //     'Vehicle Registration Number',
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Text(
                  //     SharedPrefsValues.vehicle_number.toUpperCase() ?? '',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  //   title: Text(
                  //     'Driving Licence',
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Text(
                  //       SharedPrefsValues.licence_number != null && SharedPrefsValues.licence_number.isNotEmpty
                  //     ?SharedPrefsValues.licence_number.toUpperCase() : '',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //         (SharedPrefsValues.licence_validupto != null
                  //             ?'(valid till: '+SharedPrefsValues.licence_validupto.toString() +') ':'(valid till : 23/10/2025)'),
                  //
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     'Licence valid Upto',
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Text(
                  //     SharedPrefsValues.licence_validupto != null
                  //       ? SharedPrefsValues.licence_validupto.toString() : '23/10/2025',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     'Licence valid Upto',
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Text(
                  //     SharedPrefsValues.licence_validupto != null
                  //         ?SharedPrefsValues.licence_validupto.toString() : '23/10/2025',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     'Licence valid Upto',
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     SharedPrefsValues.licence_validupto != null
                  //         ?SharedPrefsValues.licence_validupto.toString() : '23/10/2025',
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                  // if (SharedPrefsValues.Address != null && SharedPrefsValues.Address.isNotEmpty)
                  //   Card(
                  //     child: ListTile(
                  //       leading: Icon(Icons.location_on),
                  //       title: Text(
                  //
                  //         style: TextStyle(
                  //           color: Colors.deepOrange,
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),


                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      SharedPrefsValues.email != null && SharedPrefsValues.email.isNotEmpty
                          ?SharedPrefsValues.email.toUpperCase() : 'test@test.in',
                      //SharedPrefsValues.email ?? "test@test.in",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                 // if (SharedPrefsValues.Address != null && SharedPrefsValues.Address.isNotEmpty)
                  ListTile(
                    title: Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      SharedPrefsValues.Address != null && SharedPrefsValues.Address.isNotEmpty
                          ?SharedPrefsValues.Address.toUpperCase() : '#123 Test Address, Chandigarh',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

       BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  onPrimary: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8), // Add some spacing between the icon and text
                    Text('Edit'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

                ],
              ),
            )
          ],
    ),

    );
  }
}