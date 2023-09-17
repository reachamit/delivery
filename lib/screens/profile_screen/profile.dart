import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:flutter/material.dart';
import 'edit_profile.dart';
import '../navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final leftSection = new Container(
    child: new CircleAvatar(
      backgroundImage: CommonUtils.loadImageAssetOrDefault(),
      backgroundColor: Colors.lightGreen,
      radius: 24.0,
    ),
  );
  final middleSection = new Container(
      padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text("Name",
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),),
          new Text("Hi whatsp?", style:
          new TextStyle(color: Colors.grey),),
        ],
      ),
    );
  final rightSection = new Container(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text("9:50",
          style: new TextStyle(
              color: Colors.lightGreen,
              fontSize: 12.0),),
        new CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 10.0,
          child: new Text("2",
            style: new TextStyle(color: Colors.white,
                fontSize: 12.0),),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    print(SharedPrefsValues.deliveryLoginStatus);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Delivery Partner'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
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
      drawer: NavBar(),
      // body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        body: SingleChildScrollView(
      child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/delivery.png'),
              fit: BoxFit.fitHeight,
              alignment: AlignmentDirectional.bottomCenter,
            ),

          ),
          child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: 8),
                // new Container(
                //     child: new Row(
                //       children: <Widget>[
                //         leftSection,
                //         middleSection,
                //         rightSection
                //       ],
                //     ),
                // ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/delivery.png'),
                      //   fit: BoxFit.cover,
                      // ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.black45,Colors.transparent,Colors.black45],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                image: DecorationImage(
                                  image: CommonUtils.loadImageAssetOrDefault(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 60),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SharedPrefsValues.name ?? '' +  SharedPrefsValues.mobile,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining, // Replace with the desired icon
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      SharedPrefsValues.vehicle_number ?? '',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone, // Replace with the desired icon
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      (SharedPrefsValues.mobile != null && SharedPrefsValues.mobile.isNotEmpty ? '+91 ' + SharedPrefsValues.mobile : ''),
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 10),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Driving License:', // Replace with your desired title
                                //       style: TextStyle(fontSize: 18),
                                //     ),
                                //     Text(
                                //       SharedPrefsValues.licence_number ?? '',
                                //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                //       textAlign: TextAlign.center,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),




                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Mobile'),
                    subtitle: Text(SharedPrefsValues.mobile),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text('Vehicle Registration'),
                    subtitle: Text(SharedPrefsValues.vehicle_number),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: Icon(Icons.local_police),
                    title: Text('Driving Licence'),
                    subtitle: Text(SharedPrefsValues.licence_number),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.local_police),
                    title: Text('Licence valid Upto'),
                    subtitle: Text(SharedPrefsValues.licence_number),
                  ),
                ),
                if (SharedPrefsValues.Address != null && SharedPrefsValues.Address.isNotEmpty)
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        SharedPrefsValues.Address,
                        // Replace with the actual address
                      ),
                    ),
                  ),

                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ],
        ),
    ),
        ),

    );
  }
}
