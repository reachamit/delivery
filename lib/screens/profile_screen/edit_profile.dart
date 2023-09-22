import 'dart:convert';

import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:image/image.dart' as Img;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final cls_DeliveryPersonProfile deliveryPersonProfile = cls_DeliveryPersonProfile();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  XFile? image;

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    mobileNumberController.text = SharedPrefsValues.mobile ?? '';
    emailController.text = SharedPrefsValues.email ?? '';
    addressController.text = SharedPrefsValues.Address ?? '';
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
         backgroundColor: Colors.red,
        title: Text('Edit Profile'),
        centerTitle: true,
        //backgroundColor: Colors.lightGreen,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            // Display circular image or "No Image" text
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                image: DecorationImage(
                  image: image != null
                      ? FileImage(File(image!.path)) // Display selected image
                      : CommonUtils.loadImageAssetOrDefault(), // Load asset or default image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                myAlert();
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: mobileNumberController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                deliveryPersonProfile.mobile_number = mobileNumberController.text;
                deliveryPersonProfile.email = emailController.text;
                deliveryPersonProfile.correspondence_address = addressController.text;
                saveProfileChanges(deliveryPersonProfile, image);
                Navigator.pop(context);
              },
              child: Text('Save'),

            ),
            SizedBox(height: 100,),
          ],
            ),
        ),
      ),
      bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
    );
  }

  Future<void> saveProfileChanges(cls_DeliveryPersonProfile updatedProfile, XFile? image) async {
    print('Updated Profile: $updatedProfile');
    await PushProfileChangesToServer(updatedProfile,image);

  }

  Future<void> PushProfileChangesToServer(cls_DeliveryPersonProfile updatedProfile,XFile? image) async {
    print(updatedProfile);
    var base64Image="";
    if (image != null) {
      try {
        if (image.name!.endsWith('.jpg') ||
            image.name!.endsWith('.jpeg')) {
          Uint8List imageBytes = await image.readAsBytes();
          base64Image = base64Encode(imageBytes);

        } else
        {
          print("Invalid image file type");// Replace with your default image path
        }
      } catch (e) {
        print("Error saving image: $e");
      }
    }
    // ignore: use_build_context_synchronously
     ApiHelper().updateProfileAndNavigate(context, updatedProfile,base64Image);

  }
}


class cls_DeliveryPersonProfile {
  String? mobile_number;
  String? email;
  String? correspondence_address;

  cls_DeliveryPersonProfile({
    this.mobile_number,
    this.email,
    this.correspondence_address,
  });
}
