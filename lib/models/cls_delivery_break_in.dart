class DeliveryPersonBreakIN {
  final String delivery_person_code;
  final String delivery_person_name;
  final String break_start_date_time;
  final double current_latitude;
  final double current_longitude;
  final String password;

  DeliveryPersonBreakIN({
    required this.delivery_person_code,
    required this.delivery_person_name,
    required this.break_start_date_time,
    required this.current_latitude,
    required this.current_longitude,
    required this.password,
  });

  factory DeliveryPersonBreakIN.fromJson(Map<String, dynamic> json) {
    return DeliveryPersonBreakIN(
      delivery_person_code: json['delivery_person_code'],
      delivery_person_name: json['delivery_person_name'],
      break_start_date_time: json['break_start_date_time'],
      current_latitude: json['current_latitude'],
      current_longitude: json['current_longitude'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'delivery_person_code': delivery_person_code,
      'delivery_person_name': delivery_person_name,
      'break_start_date_time': break_start_date_time,
      'current_latitude': current_latitude,
      'current_longitude': current_longitude,
      'password': password,
    };
  }
}
