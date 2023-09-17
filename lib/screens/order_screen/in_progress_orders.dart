import 'package:flutter/material.dart';

class InProgressOrders extends StatelessWidget {
   InProgressOrders({Key? key}) : super(key: key);

  // Dummy data for in-progress orders
   final List<Map<String, String>> inProgressOrderList = [
     {
       'orderNumber': 'Order #1',
       'details': 'Details for Order #1',
       'acceptedTime': '2023-08-29 10:30 AM'
     },
     {
       'orderNumber': 'Order #2',
       'details': 'Details for Order #2',
       'acceptedTime': '2023-08-29 11:45 AM'
     },
     {
       'orderNumber': 'Order #3',
       'details': 'Details for Order #3',
       'acceptedTime': '2023-08-29 2:15 PM'
     },
     // Add more orders here
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-Progress Orders"),
      ),
      body: ListView.builder(
        itemCount: inProgressOrderList.length,
        itemBuilder: (BuildContext context, int index) {
          final orderData = inProgressOrderList[index];
          return ListTile(
            title: Text(orderData['orderNumber']!),
            onTap: () {
              _showOrderDetailsDialog(context, orderData);
            },
          );
        },
      ),
    );
  }
   void _showOrderDetailsDialog(BuildContext context, Map<String, String> orderData) {
     showDialog(
       context: context,
       builder: (BuildContext dialogContext) {
         return AlertDialog(
           title: Text(orderData['orderNumber']!),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('Details: ${orderData['details']}'),
               SizedBox(height: 8),
               Text('Accepted Time: ${orderData['acceptedTime']}'),
             ],
           ),
           actions: [
             TextButton(
               onPressed: () {
                 Navigator.pop(dialogContext); // Close the dialog
               },
               child: Text("Close"),
             ),
           ],
         );
       },
     );
   }
}
