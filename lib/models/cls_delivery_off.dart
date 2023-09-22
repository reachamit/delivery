class DeliveryPersonOUT {
  final String delivery_person_code;
  final String delivery_person_name;
  final String out_date_time;
  final double current_latitude;
  final double current_longitude;
  final String password;

  DeliveryPersonOUT({
    required this.delivery_person_code,
    required this.delivery_person_name,
    required this.out_date_time,
    required this.current_latitude,
    required this.current_longitude,
    required this.password,
  });

  factory DeliveryPersonOUT.fromJson(Map<String, dynamic> json) {
    return DeliveryPersonOUT(
      delivery_person_code: json['delivery_person_code'],
      delivery_person_name: json['delivery_person_name'],
      out_date_time: json['out_date_time'],
      current_latitude: json['current_latitude'],
      current_longitude: json['current_longitude'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'delivery_person_code': delivery_person_code,
      'delivery_person_name': delivery_person_name,
      'out_date_time': out_date_time,
      'current_latitude': current_latitude,
      'current_longitude': current_longitude,
      'password': password,
    };
  }
}
