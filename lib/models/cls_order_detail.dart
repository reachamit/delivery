class OrderDetail {
  final String? customername;
  final String? customermobile;
  final String? customeremail;
  final String? customerCode;
  final String? customerVendorCode;
  final String? deliveryAddress;
  final String? deliveryMethod;
  final double? billAmount;
  final double? deliveryCharges;
  final String? orderNumber;
  final String? orderReceived;
  final DateTime? dateTime;
  final String? deliveryPersonCode;
  final String? status;
  final String? pickedUp;
  final DateTime? pickupDateTime;
  final String? pickedUpBy;
  final String? vendorCode;
  final String? delivered;
  final DateTime? deliveredDateTime;
  final String? otpMatch;
  final String? paymentTaken;
  final double? amount;
  final double? delivery_latitude;
  final double? delivery_longitude;


  OrderDetail({
    this.customername,
    this.customermobile,
    this.customeremail,
    this.customerCode,
    this.customerVendorCode,
    this.deliveryAddress,
    this.deliveryMethod,
    this.billAmount,
    this.deliveryCharges,
    this.orderNumber,
    this.orderReceived,
    this.dateTime,
    this.deliveryPersonCode,
    this.status,
    this.pickedUp,
    this.pickupDateTime,
    this.pickedUpBy,
    this.vendorCode,
    this.delivered,
    this.deliveredDateTime,
    this.otpMatch,
    this.paymentTaken,
    this.amount,
    this.delivery_latitude,
    this.delivery_longitude,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> orderData) {
    var result= OrderDetail(
      customername: orderData['customername']??"",
      customermobile: orderData['customermobile'].toString(),
      customeremail: orderData['customeremail']??"",
      customerCode: orderData['customercode']??"",
      customerVendorCode: orderData['customer_vendorcode']??"",
      deliveryAddress: orderData['deliveryaddress']??"",
      deliveryMethod: orderData['delivery_method']??"",
      billAmount: orderData['bill_amount']?.toDouble(),
      deliveryCharges: orderData['delivery_charges']?.toDouble(),
      orderNumber: orderData['ordernumber']??"",
      orderReceived: orderData['order_received']??"",
      dateTime: orderData['date_time'] != null ? DateTime.parse(orderData['date_time']) : null,
      deliveryPersonCode: orderData['delivery_person_code']??"",
      status: orderData['status']??"",
      pickedUp: orderData['picked_up']??'N',
      pickupDateTime: orderData['pickup_date_time'] != null ? DateTime.parse(orderData['pickup_date_time']) : null,
      pickedUpBy: orderData['picked_up_by']??"",
      vendorCode: orderData['vendorcode']??"",
      delivered: orderData['delivered']??"N",
      deliveredDateTime: orderData['delivered_date_time'] != null ? DateTime.parse(orderData['delivered_date_time']) : null,
      otpMatch: orderData['otp_match']??'N',
      paymentTaken: orderData['payment_taken']??'N',
      amount: orderData['amount']?.toDouble(),
      delivery_latitude: orderData['delivery_latitude']?.toDouble(),
      delivery_longitude: orderData['delivery_longitude']?.toDouble(),
    );

    print('result');
    print(result);
    return result;
  }
}
class OrderDetailsList {
  List<OrderDetail> orderDetailsList;

  OrderDetailsList({required this.orderDetailsList});

  factory OrderDetailsList.fromJsonList(List<dynamic> list) {
    List<OrderDetail> orderDetailsList = list.map((data) {
      return OrderDetail.fromJson(data);
    }).toList();

    return OrderDetailsList(orderDetailsList: orderDetailsList);
  }
}