import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/models/cls_vehicle_registration.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:flutter/material.dart';
import 'package:delivery/common_utility/date_form_field.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditVehicleRegistrationScreen extends StatefulWidget {
  final String initialVehicleType;
  final String initialVehicleRegistrationNumber;
  final DateTime? initialVehicleRegistrationDate;
  final String initialDrivingLicenseNumber;
  final String initialVehicleInsuranceNumber;
  final DateTime? initialVehicleInsuranceValidUntil;

  EditVehicleRegistrationScreen({
    required this.initialVehicleType,
    required this.initialVehicleRegistrationNumber,
    required this.initialVehicleRegistrationDate,
    required this.initialDrivingLicenseNumber,
    required this.initialVehicleInsuranceNumber,
    required this.initialVehicleInsuranceValidUntil,
  });

  @override
  _EditVehicleRegistrationScreenState createState() =>
      _EditVehicleRegistrationScreenState();
   }

class _EditVehicleRegistrationScreenState
    extends State<EditVehicleRegistrationScreen> {
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
 // var _dateMaskFormatter = MaskTextInputFormatter(mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    print('widget.initialVehicleRegistrationDate');
    print(widget.initialVehicleRegistrationDate);
    print('widget.initialVehicleInsuranceValidUntil');
    print(widget.initialVehicleInsuranceValidUntil);
  
    _registrationDateController = TextEditingController(text: widget.initialVehicleRegistrationDate==null?"":widget.initialVehicleRegistrationDate.toString());
    _insuranceUptoDateController = TextEditingController(text: widget.initialVehicleInsuranceValidUntil==null?"":widget.initialVehicleInsuranceValidUntil.toString());
    selectedVehicleType = widget.initialVehicleType;
  }

  @override
  void dispose() {
    _registrationDateController.dispose();
    _insuranceUptoDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.red,
        title: Text('Edit Vehicle Registration'),
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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Vehicle Type'),
                  value: selectedVehicleType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVehicleType = newValue;
                    });
                  },
                  items: ['Car', 'Bike', 'Scooter']
                      .map<DropdownMenuItem<String>>((String value) {
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
                    vehicleType = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Registration Number',
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
                    return null;
                  },
                  onSaved: (value) {
                    vehicleRegistrationNumber = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'License Number'),
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
                  decoration: const InputDecoration(labelText: 'Insurance Number'),
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
              TextFormField(
  controller: _registrationDateController,
  decoration: const InputDecoration(
    icon: Icon(Icons.calendar_today),
    labelText: "Registration Date",
  ),
  readOnly: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the registration date';
    } else if (selectedDate != null && selectedDate!.isAfter(DateTime.now())) {
      return 'Please enter a valid registration date';
    }
    return null;
  },
  onTap: () async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);
      setState(() {
        _registrationDateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
      setState(() {
        _registrationDateController.text = ''; // Set an empty string when date is not selected
      });
    }
  },
),
   TextFormField(
                      controller: _insuranceUptoDateController, //editing controller of this TextField
                      decoration: const InputDecoration( 
                                icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "Insurance Valid Upto" //label text of field
                        ),
                      readOnly: true,
                       validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insurance validity date';
                  } else if (selectedDate != null && selectedDate!.isAfter(DateTime.now())) {
                    return 'Please enter a valid insurance date';
                  }
                  return null;
                },
                      onTap: () async {
                     DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                      setState(() {
                         _insuranceUptoDateController.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                        }
              ),
              
              
            
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      VehicleRegistration _deliveryperson = VehicleRegistration(
                        delivery_person_code: SharedPrefsValues.deliveryPersonCode, 
                        vehical_type: selectedVehicleType?? 'BIKE', 
                        vehical_registration_number: vehicleRegistrationNumber,
                        vehical_registration_date: vehicleRegistrationDate, 
                        driving_license_number: drivingLicenseNumber, 
                        vehicle_insurance_number: vehicleInsuranceNumber, 
                        vehicle_insurance_valid_upto: vehicleInsuranceValidUntil
                        );


                      // Perform any update logic here
                          ApiHelper.UpdateVehicleDetailsDeliveryPerson(_deliveryperson);
                      // Navigate back to the display screen
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
