
import 'package:delivery/common_utility/date_form_field.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:flutter/material.dart';
 import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class VehicleRegistrationForm extends StatefulWidget {
  @override
  _VehicleRegistrationFormState createState() => _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _registrationDateController;
  late TextEditingController _insuranceUptoDateController;
  DateTime? selectedDate;
  String? selectedVehicleType;
  String vehicleType = '';
  String vehicleRegistrationNumber = '';
  DateTime? vehicleRegistrationDate;
  String drivingLicenseNumber = '';
  String vehicleInsuranceNumber = '';
  DateTime? vehicleInsuranceValidUntil;
  var _dateMaskFormatter = MaskTextInputFormatter(mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});

  // bool validateIndianVehicleRegistrationNumber(String registrationNumber) {
  //   final pattern = r'^[A-Z]{2}\s?[0-9]{2}\s?[A-Z]{2}\s?[0-9]{4}$';
  //
  //   final regex = RegExp(pattern);
  //   return regex.hasMatch(registrationNumber);
  // }

  @override
  void initState() {
    super.initState();
    _registrationDateController = TextEditingController();
    _insuranceUptoDateController = TextEditingController();
  }

  @override
  void dispose() {
    _registrationDateController.dispose(); // Dispose of the controller when the widget is disposed
    _insuranceUptoDateController.dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration Form'),
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
      body: SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

          DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: 'Vehicle Type'),
          value: selectedVehicleType,
          onChanged: (newValue) {
            // Update the selected value when the user makes a selection.
            setState(() {
              selectedVehicleType = newValue;
            });
          },
          items: ['Car', 'Bike', 'Scooter'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a vehicle type';
            }
            return null;
          },
          onSaved: (value) {
            // Handle saving the selected value as needed.
            vehicleType = value ?? '';
          },
        ),

          // TextFormField(
              //   decoration: InputDecoration(labelText: 'Vehicle Type'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the vehicle type';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     vehicleType = value ?? '';
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Registration Number',
                  hintText: 'XX XX XX XXXX',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration number';
                  }
                  // else if (!validateIndianVehicleRegistrationNumber(value)) {
                  //   return 'Invalid vehicle registration number';
                  // }
                  return null;
                },
                onSaved: (value) {
                  vehicleRegistrationNumber = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'License Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the license number';
                  }
                  return null;
                },
                onSaved: (value) {
                  drivingLicenseNumber = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Insurance Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insurance number';
                  }
                  return null;
                },
                onSaved: (value) {
                  vehicleInsuranceNumber = value ?? '';
                },
              ),

              DateFormField(
                    labelText: 'Registration Date',
                    controller: _registrationDateController,
                    inputFormatter: _dateMaskFormatter,
                    futureValueAllowed:0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the registration date';
                      } else if (selectedDate != null && selectedDate!.isAfter(DateTime.now())) {
                        return 'Please enter a valid registration date';
                      }
                      return null;
                    },
                  ),
              DateFormField(
                labelText: 'Insurance Valid Upto',
                controller: _insuranceUptoDateController,
                inputFormatter: _dateMaskFormatter,
                futureValueAllowed:1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insurance validity date';
                  } else if (selectedDate != null && selectedDate!.isAfter(DateTime.now())) {
                    return 'Please enter a valid registration date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Form data is valid, you can access it
                    print('Vehicle Type: $vehicleType');
                    print('Registration Number: $vehicleRegistrationNumber');
                    print('Registration Date: $vehicleRegistrationDate');
                    print('License Number: $drivingLicenseNumber');
                    print('Insurance Number: $vehicleInsuranceNumber');
                    print('Insurance Valid Until: $vehicleInsuranceValidUntil');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
              ),
      ),
    );
  }
}
