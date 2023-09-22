import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      color: Colors.red, // You can customize the color
      child: Text(
        "Your account is not activated yet.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
