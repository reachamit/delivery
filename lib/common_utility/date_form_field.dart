import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final MaskTextInputFormatter inputFormatter;
  final int futureValueAllowed;


  DateFormField({
    required this.labelText,
    required this.controller,
    required this.inputFormatter,
    required this.futureValueAllowed,
    this.validator,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime firstSelectableDate = DateTime(2000);
    DateTime lastSelectableDate = DateTime(2101);
    if (futureValueAllowed == 0) {
      // Disable future dates
      lastSelectableDate = currentDate;
    } else if (futureValueAllowed == 1) {
      // Disable past dates
      firstSelectableDate = currentDate;
    }

    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: controller.text.isEmpty
          ? currentDate
          : DateFormat('dd-MM-yyyy').parse(controller.text),
      firstDate: firstSelectableDate,
      lastDate: lastSelectableDate,
    )) ?? currentDate;

    if (futureValueAllowed == 0 && picked.isAfter(currentDate)) {
      controller.clear();
    } else {
      controller.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [inputFormatter], // Add the MaskTextInputFormatter here
      decoration: InputDecoration(
        labelText: labelText,
        hintText: inputFormatter.maskText('dd-MM-YYYY'),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ),
      validator: validator,
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
    );
  }
}

// Usage example:
// DateFormField(
//   labelText: 'Registration Date',
//   controller: _dateController,
//   inputFormatter: _dateMaskFormatter, // Pass the MaskTextInputFormatter here
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter the registration date';
//     } else if (selectedDate != null && selectedDate.isAfter(DateTime.now())) {
//       return 'Please enter a valid registration date';
//     }
//     return null;
//   },
// ),
