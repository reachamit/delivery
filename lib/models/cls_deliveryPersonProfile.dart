class DeliveryPerson {
  final String deliveryPersonCode;
  final String deliveryPersonName;
  final String gender;
  final String dateOfBirth;
  final String mobileNumber;
  final bool mobileNumberVerified;
  final String email;
  final bool emailVerified;
  final String addressCorrespondence;
  final String addressPermanent;
  final String vehicleType;
  final String vehicleRegistrationNumber;
  final String status;
  final String agencyCode;
  final String deliveryPersonKey;
  final String deliveryPersonIdentity;
  final String drivingLicenseNo;
  final String vehicleRegistrationDate;
  final String passwd;
  final String drivingLicenseNumber;
  final String vehicleInsuranceNumber;
  final String vehicleInsuranceValidUpto;
  final bool vehicleInsuranceRenewed;
  final bool vehicleInsuranceVerified;
  final String drivingLicenseValidUpto;
  final bool drivingLicenseVerified;
  final bool vehicleRcVerified;
  final String deliveryPersonRegistrationDateTime;
  final String otp;
  final String deliveryPersonPhoto;
  final String vehicleRegistrationValidUpto;

  DeliveryPerson({
    required this.deliveryPersonCode,
    required this.deliveryPersonName,
    required this.gender,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.mobileNumberVerified,
    required this.email,
    required this.emailVerified,
    required this.addressCorrespondence,
    required this.addressPermanent,
    required this.vehicleType,
    required this.vehicleRegistrationNumber,
    required this.status,
    required this.agencyCode,
    required this.deliveryPersonKey,
    required this.deliveryPersonIdentity,
    required this.drivingLicenseNo,
    required this.vehicleRegistrationDate,
    required this.passwd,
    required this.drivingLicenseNumber,
    required this.vehicleInsuranceNumber,
    required this.vehicleInsuranceValidUpto,
    required this.vehicleInsuranceRenewed,
    required this.vehicleInsuranceVerified,
    required this.drivingLicenseValidUpto,
    required this.drivingLicenseVerified,
    required this.vehicleRcVerified,
    required this.deliveryPersonRegistrationDateTime,
    required this.otp,
    required this.deliveryPersonPhoto,
    required this.vehicleRegistrationValidUpto,
  });

  factory DeliveryPerson.fromJson(Map<String, dynamic> json) {
  return DeliveryPerson(
  deliveryPersonCode: json['delivery_person_code'],
  deliveryPersonName: json['delivery_person_name'],
  gender: json['gender'],
  dateOfBirth: json['date_of_birth'],
  mobileNumber: json['mobile_number'],
  mobileNumberVerified: json['mobile_number_verified'],
  email: json['email'],
  emailVerified: json['email_verified'],
  addressCorrespondence: json['address_correspondence'],
  addressPermanent: json['address_permanent'],
  vehicleType: json['vehical_type'],
  vehicleRegistrationNumber: json['vehical_registration_number'],
  status: json['status'],
  agencyCode: json['agencycode'],
  deliveryPersonKey: json['delivery_person_key'],
  deliveryPersonIdentity: json['delivery_person_identity'],
  drivingLicenseNo: json['driving_license_no'],
  vehicleRegistrationDate: json['vehical_registration_date'],
  passwd: json['passwd'],
  drivingLicenseNumber: json['driving_license_number'],
  vehicleInsuranceNumber: json['vehicle_insurance_number'],
  vehicleInsuranceValidUpto: json['vehicle_insurance_valid_upto'],
  vehicleInsuranceRenewed: json['vehicle_insurance_renewed'],
  vehicleInsuranceVerified: json['vehicle_insurance_verified'],
  drivingLicenseValidUpto: json['driving_license_valid_upto'],
  drivingLicenseVerified: json['driving_license_verified'],
  vehicleRcVerified: json['vehical_rc_verified'],
  deliveryPersonRegistrationDateTime: json['delivery_person_registration_date_time'],
  otp: json['otp'],
  deliveryPersonPhoto: json['delivery_person_photo'],
  vehicleRegistrationValidUpto: json['vehicle_registration_valid_upto'],
  );
  }

  Map<String, dynamic> toJson() {
  return {
  'delivery_person_code': deliveryPersonCode,
  'delivery_person_name': deliveryPersonName,
  'gender': gender,
  'date_of_birth': dateOfBirth,
  'mobile_number': mobileNumber,
  'mobile_number_verified': mobileNumberVerified,
  'email': email,
  'email_verified': emailVerified,
  'address_correspondence': addressCorrespondence,
  'address_permanent': addressPermanent,
  'vehical_type': vehicleType,
  'vehical_registration_number': vehicleRegistrationNumber,
  'status': status,
  'agencycode': agencyCode,
  'delivery_person_key': deliveryPersonKey,
  'delivery_person_identity': deliveryPersonIdentity,
  'driving_license_no': drivingLicenseNo,
  'vehical_registration_date': vehicleRegistrationDate,
  'passwd': passwd,
  'driving_license_number': drivingLicenseNumber,
  'vehicle_insurance_number': vehicleInsuranceNumber,
  'vehicle_insurance_valid_upto': vehicleInsuranceValidUpto,
  'vehicle_insurance_renewed': vehicleInsuranceRenewed,
  'vehicle_insurance_verified': vehicleInsuranceVerified,
  'driving_license_valid_upto': drivingLicenseValidUpto,
  'driving_license_verified': drivingLicenseVerified,
  'vehical_rc_verified': vehicleRcVerified,
  'delivery_person_registration_date_time': deliveryPersonRegistrationDateTime,
  'otp': otp,
  'delivery_person_photo': deliveryPersonPhoto,
  'vehicle_registration_valid_upto': vehicleRegistrationValidUpto,
  };
  }
  }



