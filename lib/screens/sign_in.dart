import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/common_util.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'register.dart';
import 'widget_helper/awesome_dialog.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Sign In'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Stack(
            fit: StackFit.expand,
            // Make the Stack expand to fill the available space
            children: [
              Image.asset('assets/images/transparent_background.jpg',
                  fit: BoxFit.cover),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Logo(),
                      _FormContent(),
                    ],
                  ),
                ),
              )
            ]));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/delivery_logo.png',
          height: 150,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Welcome to Order Her Food!! \n"
            "Login as a Rider",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          // child: Text(
          //   "Welcome to Order Her Food!",
          //   textAlign: TextAlign.center,
          //   style: isSmallScreen
          //       ? Theme.of(context).textTheme.bodyLarge
          //       : Theme.of(context)
          //       .textTheme
          //       .headlineLarge
          //       ?.copyWith(color: Colors.black),
          // ),
        )
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
  String _mobileNumber = "DP0308202311";
  String _password = "7301";
  final upperCaseFormatter = UpperCaseTextFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter mobile number';
                }
                // else if (value.length != 10) {
                //   return 'Mobile number should be 10 digits';
                // }
                return null;
              },
              onChanged: (value) {
                _mobileNumber = value.toUpperCase();
              },
              initialValue: _mobileNumber,
              //keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'mobile/delivery person code',
                hintText: 'Enter mobile/delivery person code',
                prefixIcon: Icon(Icons.mobile_friendly_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }

                // if (value.length < 6) {
                //   return 'Password must be at least 6 characters';
                // }
                return null;
              },
              onChanged: (value) {
                _password = value.toUpperCase();
              },
              initialValue: _password,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            FloatingActionButton.extended(
              label: Text('Sign In'),
              backgroundColor: Colors.lightGreen,
              icon: Icon(
                Icons.login_rounded,
                size: 15.0,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //if (_formKey.currentState?.validate() ?? false) {
                  // _mobileNumber="DP1208202355";
                  //_password="1234";

                  Signin_DeliveryPerson(context, _mobileNumber, _password);
                } else {
                  // AwesomeDialogHelper.showAwesomeDialog(
                  //     context: context,
                  //     title: 'Error',
                  //     description:
                  //     'Please enter valid username or password.',
                  //     dialogType: DialogType.success);
                  CommonUtils.showSnackBar(
                    context,
                    'Please enter valid username or password.',
                    backgroundColor: Colors.red,
                  );
                }
              },
            ),
            _gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegisterDeliveryPerson()));
                  },
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Text('Forgot Password'),
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
          title: const Text('Success'),
          content: Text(responseData),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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

void Signin_DeliveryPerson(
    BuildContext context, String deliveryPersonCode, String password) async {
  try {
    final Map<String, dynamic> profileDetailsMap =
        await ApiHelper().LoginIntoDeliveryApp(deliveryPersonCode, password);
    print('Signin_DeliveryPerson');
    print(profileDetailsMap);
    String success = profileDetailsMap['Success'];
    print(profileDetailsMap['Success']);
    if (success == 'Y') {
      final String deliveryPersonCode =
          profileDetailsMap['Data']['delivery_person_code'];
      final String deliveryPersonName =
          profileDetailsMap['Data']['delivery_person_name'];
      final String gender = profileDetailsMap['Data']['gender'] ?? "";
      final String dateOfBirth =
          profileDetailsMap['Data']['date_of_birth'] ?? "";
      final String mobileNumber =
          profileDetailsMap['Data']['mobile_number'].toString();
      final String email = profileDetailsMap['Data']['email'] ?? "";
      final String addressCorrespondence =
          profileDetailsMap['Data']['address_correspondance'] ?? "";
      final String addressPermanent =
          profileDetailsMap['Data']['address_permanent'] ?? "";
      // final String vehicleType = profileDetailsMap['Data']['vehical_type'];
      final String vehicleRegistrationNumber =
          profileDetailsMap['Data']['vehical_registration_number'] ?? "";
      final String status = profileDetailsMap['Data']['status'] ?? "P";
      // final String agencyCode = profileDetailsMap['Data']['agencycode'];
      final String deliveryPersonKey =
          profileDetailsMap['Data']['delivery_person_key'];
      // final String deliveryPersonIdentity = profileDetailsMap['Data']['delivery_person_identity'];
      final String drivingLicenseNo =
          profileDetailsMap['Data']['driving_license_no'] ?? "";
      final String vehicleRegistrationDate =
          profileDetailsMap['Data']['vehical_registration_date'] ?? "";
      final String password = profileDetailsMap['Data']['passwd'];

      AppSharedPreferences.setStringValue("name", deliveryPersonName);
      AppSharedPreferences.setStringValue("email", email);
      AppSharedPreferences.setStringValue("mobile", mobileNumber);
      AppSharedPreferences.setStringValue("dateOfBirth", dateOfBirth);
      AppSharedPreferences.setStringValue(
          "vehicleNumber", vehicleRegistrationNumber);
      AppSharedPreferences.setStringValue("licenceNumber", drivingLicenseNo);
      AppSharedPreferences.setStringValue(
          "deliveryPersonCode", deliveryPersonCode);
      AppSharedPreferences.setStringValue(
          "deliveryPersonKey", deliveryPersonKey);
      AppSharedPreferences.setStringValue("Password", password);
      AppSharedPreferences.setStringValue(
          "isAccountActivated", status == "A" ? "Y" : "N");
      AppSharedPreferences.setBool('isLoggedIn', true);
      // ignore: use_build_context_synchronously
      // AwesomeDialogHelper.showAwesomeDialog(
      //     context: context,
      //     title: 'Success',
      //     description:
      //         'Sign In successfully. Delivery Person Code: $deliveryPersonCode',
      //     dialogType: DialogType.success);

      CommonUtils.showSnackBar(
        context,
        'Sign In successfully. Delivery Person Code: $deliveryPersonCode',
        backgroundColor: Colors.green,
      );
      final statuses = await [
        Permission.location,
        Permission.camera,
        Permission.storage,
      ].request();
      for (var permission in statuses.keys) {
        if (statuses[permission]!.isDenied) {
          print("${permission.toString()} permission is denied.");
        }
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Attandance()));
    } else {
      String message = profileDetailsMap['Data']['ErrorMessage'];
      print(message);
      // ignore: use_build_context_synchronously
      CommonUtils.showSnackBar(context, message, backgroundColor: Colors.red);
    }
  } catch (e) {
    print(e);
    CommonUtils.showSnackBar(context, 'Error occurred while Sign-In: $e',
        backgroundColor: Colors.red);
  }
  //----------
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
