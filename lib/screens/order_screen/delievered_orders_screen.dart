import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeliveredOrdersScreen extends StatefulWidget {
  @override
  _DeliveredOrdersScreenState createState() => _DeliveredOrdersScreenState();
}

class _DeliveredOrdersScreenState extends State<DeliveredOrdersScreen> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('YOUR_API_URL_HERE'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        orders = List<Order>.from(data.map((item) => Order.fromJson(item)));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.red,
        title: Text('Delivered Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order.orderNumber),
            subtitle: Text(order.amount.toString()),
          );
        },
      ),
    );
  }
}

class Order {
  final String orderNumber;
  final double amount;

  Order({
    required this.orderNumber,
    required this.amount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'],
      amount: json['amount'].toDouble(),
    );
  }
}
