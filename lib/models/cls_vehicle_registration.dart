class VehicleRegistration {
  String delivery_person_code;
  String vehical_type;
  String vehical_registration_number;
  DateTime vehical_registration_date;
  String driving_license_number;
  String vehicle_insurance_number;
  DateTime vehicle_insurance_valid_upto;

  VehicleRegistration({
    required this.delivery_person_code,
    required this.vehical_type,
    required this.vehical_registration_number,
    required this.vehical_registration_date,
    required this.driving_license_number,
    required this.vehicle_insurance_number,
    required this.vehicle_insurance_valid_upto,
  });

  factory VehicleRegistration.fromJson(Map<String, dynamic> json) {
    return VehicleRegistration(
      delivery_person_code: json['delivery_person_code'],
      vehical_type: json['vehical_type'],
      vehical_registration_number: json['vehical_registration_number'],
      vehical_registration_date: json['vehical_registration_date'],
      driving_license_number: json['driving_license_number'],
      vehicle_insurance_number: json['vehicle_insurance_number'],
      vehicle_insurance_valid_upto: json['vehicle_insurance_valid_upto'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'delivery_person_code': delivery_person_code,
      'vehical_type': vehical_type,
      'vehical_registration_number': vehical_registration_number,
      'vehical_registration_date': vehical_registration_date,
      'driving_license_number': driving_license_number,
      'vehicle_insurance_number': vehicle_insurance_number,
      'vehicle_insurance_valid_upto': vehicle_insurance_valid_upto,
    };
  }
}