import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogHelper {
  static Future<void> showAwesomeDialog({
    required BuildContext context,
    required String title,
    required String description,
    required DialogType dialogType,
    AnimType animType = AnimType.SCALE,

  }) async {
    AwesomeDialog(
      context: context,
      animType: animType,
      dialogType: dialogType,
      body: Center(
        child: Text(
          description,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: title,
      desc: description,
    )..show();
  }
}
