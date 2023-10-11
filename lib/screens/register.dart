import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in.dart';
import 'validate_otp.dart';


class RegisterDeliveryPerson extends StatelessWidget {
  const RegisterDeliveryPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Welcome to OrderHerFood!'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
          fit: StackFit.expand,
          // Make the Stack expand to fill the available space
          children: [
            Image.asset('assets/images/transparent_background.jpg',
                fit: BoxFit.cover),
            SingleChildScrollView(
              child: Center(
                  child: isSmallScreen
                      ? Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: const [
                            _Logo(),
                            _FormContent(),
                          ],
                        )
                      : Container(
                          //padding: const EdgeInsets.all(32.0),
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Row(
                            children: const [
                              Expanded(child: _Logo()),
                              Expanded(
                                child: Center(child: _FormContent()),
                              ),
                            ],
                          ),
                        )),
            )
          ]),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //FlutterLogo(size: isSmallScreen ? 100 : 200),
        Image.asset(
          'assets/images/delivery_logo.png',
          height: isSmallScreen ? 150 : 300,
        ),
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _vehicleNumber = '';
  String _drivingLicenseNumber = '';
  String _mobileNumber = '';
  String _password = '';
  final upperCaseFormatter = UpperCaseTextFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [Colors.lightGreen, Colors.white54],
      //   ),
      // ),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              inputFormatters: [upperCaseFormatter],
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
              onChanged: (value) {
                _name = value.toUpperCase();
              },
              decoration: const InputDecoration(
                labelText: 'Delivery Person Name',
                hintText: 'Enter your name',
                prefixIcon: Icon(Icons.person_2),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter mobile number';
                }
                return null;
              },
              onChanged: (value) {
                _mobileNumber = value.toUpperCase();
              },
              decoration: const InputDecoration(
                prefixText: "+91 ",
                labelText: 'Mobile Number',
                hintText: 'Enter mobile number',
                prefixIcon: Icon(Icons.mobile_friendly_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              inputFormatters: [upperCaseFormatter],
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle number';
                }
                // String pattern = r'^[A-Z]{2}\d{2}[A-Z]{1,2}\d{4}$';
                // if (!RegExp(pattern).hasMatch(value)) {
                //   return 'Please enter a valid vehicle number';
                // }
                return null;
              },
              onChanged: (value) {
                _vehicleNumber = value.toUpperCase();
              },
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                hintText: 'Enter your vehicle number',
                prefixIcon: Icon(Icons.directions_car_filled_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              inputFormatters: [upperCaseFormatter],
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter driving licence number';
                }
                return null;
              },
              onChanged: (value) {
                _drivingLicenseNumber = value.toUpperCase();
              },
              decoration: const InputDecoration(
                labelText: 'Driving Licence Number',
                hintText: 'Enter driving licence number',
                prefixIcon: Icon(Icons.directions_car_filled_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      //
                      //   if (_formKey.currentState?.validate() ?? false) {
                      // _name= "AMIT Dadhwal";
                      // _vehicleNumber= "HP40E6694";
                      // _drivingLicenseNumber= "YYUTUU57856";
                      // _mobileNumber= "9876567654";
                     final String?  FCMToken = await CommonUtils.retrieveAndPrintFCMToken();

                      final postData = {
                        'delivery_person_name': _name,
                        'vehical_registration_number': _vehicleNumber,
                        'driving_license_no': _drivingLicenseNumber,
                        'mobile_number': _mobileNumber,
                        'mobile_device_token': FCMToken
                      };
                      print(postData);
                      final postResponse =  await CommonUtils.postRequest("registerdeliverypersonmobile", postData);
                      if (postResponse.success) {
                        print("API Response: ${postResponse.data}");
                        //logic
                        //--------------------
                        final jsonResponse = json.decode(postResponse.data);
                        final IsSuccess = jsonResponse['Success'];
                        if(IsSuccess=='Y')
                        {
                          await FirebaseMessaging.instance.subscribeToTopic("OrderHerFoodDelivery");

                          print('subscribeToTopic');

                          final deliveryPersonCode = jsonResponse['Data']['delivery_person_code'];
                          final deliveryPersonKey = jsonResponse['Data']['delivery_person_key'];
                          final password = jsonResponse['Data']['Password'];
                          final otp = jsonResponse['Data']['otp'];

                          AppSharedPreferences.setStringValue("name", _name);
                          AppSharedPreferences.setStringValue("mobile", _mobileNumber);
                          AppSharedPreferences.setStringValue("VehicleNumber", _vehicleNumber);
                          AppSharedPreferences.setStringValue("LicenceNumber", _drivingLicenseNumber);
                          AppSharedPreferences.setStringValue("deliveryPersonCode", deliveryPersonCode);
                          AppSharedPreferences.setStringValue("deliveryPersonKey", deliveryPersonKey);
                          AppSharedPreferences.setStringValue("Password", password);
                          AppSharedPreferences.setStringValue("otp", otp);
                          AppSharedPreferences.setBool('isLoggedIn', true);
                          print('subscribeToTopic!!');

                          CommonUtils.showSnackBar(context,'Form submitted successfully. OTP has been send on ${_mobileNumber}',
                            backgroundColor: Colors.green,
                          );


                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  OTPScreen()));
                        }
                        else
                        {
                          CommonUtils.showSnackBar(context,"Error in processing request",
                              backgroundColor: Colors.red);
                        }
                        //-------------------
                      } else {
                        print("API Error: ${postResponse.error}");
                        CommonUtils.showSnackBar(context,"API Error: ${postResponse.error}",
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                    // }
                    // Navigator.push(context,MaterialPageRoute(builder: (context) =>  OTPScreen()));
                  },
                  child: Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  SignIn()));
                  },
                  child: Text('Sign In'),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);

  void _showSuccessDialog(String responseData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(responseData),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
            ),
          ],
        );
      },
    );
  }
}

class FormModel with ChangeNotifier {
  late String _registrationKey;

  String get registrationKey => _registrationKey ?? '';

  set registrationKey(String registrationKey) {
    _registrationKey = registrationKey;
    notifyListeners();
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
