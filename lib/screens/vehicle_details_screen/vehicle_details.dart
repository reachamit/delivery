import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/vehicle_details_screen/register_vehicle.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VehicleRegistrationForm extends StatelessWidget {

   String vehicleType= SharedPrefsValues.vehicle_type;
   String vehicleRegistrationNumber=SharedPrefsValues.vehicle_number;
   DateTime? vehicleRegistrationDate = SharedPrefsValues.registration_date ;
   String drivingLicenseNumber = SharedPrefsValues.licence_number;
   String vehicleInsuranceNumber=SharedPrefsValues.insurance_number;
   DateTime? vehicleInsuranceValidUntil = SharedPrefsValues.licence_validupto;
  VehicleRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text('Vehicle Registration'),
    backgroundColor: Colors.red, // Set the app bar color to red
    actions: [
      IconButton(
        icon: const Icon(
          Icons.notifications,
          color: Colors.white, // Set the icon color to white
        ),
        onPressed: () {
          // Add logic for notifications
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.home,
          color: Colors.white, // Set the icon color to white
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Attandance()),
          );
        },
      ),
    ],
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Type: $vehicleType',
          style: const TextStyle(
            fontSize: 18, // Adjust the text size
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        Text('Registration Number: $vehicleRegistrationNumber'),
        Text(
          'Registration Date: ${vehicleRegistrationDate ?? ""}',
          style: const TextStyle(
            fontStyle: FontStyle.italic, // Make the text italic
          ),
        ),
        Text('License Number: $drivingLicenseNumber'),
        Text('Insurance Number: $vehicleInsuranceNumber'),
        Text(
          'Insurance Valid Until: ${vehicleInsuranceValidUntil ?? ""}',
          style: const TextStyle(
            fontStyle: FontStyle.italic, // Make the text italic
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final Map<String, dynamic>? editedData = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditVehicleRegistrationScreen(
                  initialVehicleType: vehicleType,
                  initialVehicleRegistrationNumber: vehicleRegistrationNumber,
                  initialVehicleRegistrationDate: vehicleRegistrationDate,
                  initialDrivingLicenseNumber: drivingLicenseNumber,
                  initialVehicleInsuranceNumber: vehicleInsuranceNumber,
                  initialVehicleInsuranceValidUntil: vehicleInsuranceValidUntil,
                ),
              ),
            );

            // Check if editedData is not null (i.e., if changes were made)
            if (editedData != null) {
              // Update the data with the edited values
              vehicleType = editedData['vehicleType'];
              vehicleRegistrationNumber = editedData['vehicleRegistrationNumber'];
              vehicleRegistrationDate = editedData['vehicleRegistrationDate'];
              drivingLicenseNumber = editedData['drivingLicenseNumber'];
              vehicleInsuranceNumber = editedData['vehicleInsuranceNumber'];
              vehicleInsuranceValidUntil = editedData['vehicleInsuranceValidUntil'];
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the button background color to red
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white, // Set the icon color to white
              ),
              SizedBox(width: 8),
              Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vehicle Registration'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               // Add logic for notifications
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               Navigator.push(context,MaterialPageRoute(builder: (context) => Attandance()));
//             },
//           ),

//         ],
      
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Vehicle Type: $vehicleType'),
//             Text('Registration Number: $vehicleRegistrationNumber'),
//             Text('Registration Date: ${vehicleRegistrationDate??""}'),
//             Text('License Number: $drivingLicenseNumber'),
//             Text('Insurance Number: $vehicleInsuranceNumber'),
//             Text('Insurance Valid Until: ${vehicleInsuranceValidUntil??""}'),
//              SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 final Map<String, dynamic>? editedData = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditVehicleRegistrationScreen(
//           initialVehicleType: vehicleType,
//           initialVehicleRegistrationNumber: vehicleRegistrationNumber,
//           initialVehicleRegistrationDate: vehicleRegistrationDate,
//           initialDrivingLicenseNumber: drivingLicenseNumber,
//           initialVehicleInsuranceNumber: vehicleInsuranceNumber,
//           initialVehicleInsuranceValidUntil: vehicleInsuranceValidUntil,
//         ),
//       ),
//     );

//     // Check if editedData is not null (i.e., if changes were made)
//     if (editedData != null) {
//       // Update the data with the edited values
//       vehicleType = editedData['vehicleType'];
//       vehicleRegistrationNumber = editedData['vehicleRegistrationNumber'];
//       vehicleRegistrationDate = editedData['vehicleRegistrationDate'];
//       drivingLicenseNumber = editedData['drivingLicenseNumber'];
//       vehicleInsuranceNumber = editedData['vehicleInsuranceNumber'];
//       vehicleInsuranceValidUntil = editedData['vehicleInsuranceValidUntil'];
//     }
//   },
//   child: Text('Edit'),
// ),
//           ],
//         ),
//       ),
//     );
   }
}
