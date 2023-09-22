import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormFieldState> _pinKey = GlobalKey<FormFieldState>();
  String enteredOTP = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.red,
        title: Text('Verify Mobile Number'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightGreen, Colors.white54],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text('Enter your OTP code:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            PinInputTextField(
              key: _pinKey,
              pinLength: 4,
              decoration: UnderlineDecoration(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                colorBuilder: PinListenColorBuilder(Colors.green, Colors.red),
              ),
              onChanged: (pin) => setState(() => enteredOTP = pin),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyOTP(),
              child: Text('Verify OTP'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't receive the code? ", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () async {
                    String messageTemplate ="You have successfully registered with OrderHerFood. Your code is ${SharedPrefsValues.deliveryPersonCode} and otp is ${SharedPrefsValues.otp}";
                    final Map<String, dynamic> response = await ApiHelper.resend_OTP_Again(SharedPrefsValues.mobile,messageTemplate);
                    if(response['success']=="Y")
                      {
                        _showAlertDialog('SMS', 'Message Sent.');
                      }
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP() async {
    if (enteredOTP == SharedPrefsValues.otp) {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Attandance()));
    } else
    {
      _pinKey.currentState?.reset();
      setState(() => enteredOTP = '');
      _showAlertDialog('Incorrect OTP', 'Please enter the correct OTP.');
    }
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
