import 'package:delivery/common_utility/api_helper.dart';
import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/models/cls_wallet.dart';
import 'package:delivery/screens/attandance.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

class DeliveryPersonWallet extends StatefulWidget {
  const DeliveryPersonWallet({Key? key}) : super(key: key);

  @override
  _DeliveryPersonWalletState createState() => _DeliveryPersonWalletState();
}

class _DeliveryPersonWalletState extends State<DeliveryPersonWallet> {
  late WalletDetails walletDetails = WalletDetails();

  @override
  void initState() {
    super.initState();
    fetchWalletDetails(SharedPrefsValues.deliveryPersonCode,SharedPrefsValues.deliveryPersonCode); // Replace with actual key
  }


  void fetchWalletDetails(String deliveryPersonCode,String Password) async {
    try {
      deliveryPersonCode='DP1208202355';
      final walletDetailsMap = await ApiHelper().getWalletDetails(deliveryPersonCode,Password);
      print('walletDetailsMap');
      print(walletDetailsMap);

      WalletDetails.fromJson(walletDetailsMap);
      setState(() {
        final isSuccess = walletDetailsMap['Success'];
        if (isSuccess == 'Y') {
          final data = walletDetailsMap['Data']; // Access the 'Data' object
          final double deliveryAmount = data['delivery_amount'];
          final double tipAmount = data['tip_amount'];
          final double liabilityAmount = data['liability_amount'];
          walletDetails = WalletDetails(
            //balance: walletDetailsMap['balance'],
            deliveryAmount: deliveryAmount,
            tipAmount: tipAmount,
            liabilityAmount: liabilityAmount,
          );
        }
      });
    } catch (e) {
      print('Error fetching wallet details: $e');
      // Handle the error, show an error message, etc.
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.red,
        title: Text('Wallet Details'),
        centerTitle: true,
        //backgroundColor: Colors.lightGreen,
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
      drawer: NavBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 8),
            Text(
              'Wallet Balance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rs ${walletDetails.balance}', // Replace with the actual wallet balance
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            Divider(),
           // SizedBox(height: 8),
            //_ProfileInfoRow(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoItem(context, "Delivery Amount", walletDetails.deliveryAmount.toString()),
                const VerticalDivider(),
                _buildInfoItem(context, "Tip Amount", walletDetails.tipAmount.toString()),
                const VerticalDivider(),
                _buildInfoItem(context, "Liability Amount", walletDetails.liabilityAmount.toString()),
              ],
            ),
            Divider(),
            Text(
              'Recent Transactions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with the actual number of transactions
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Transaction #$index'),
                    subtitle: Text('Amount: \$50.00'), // Replace with transaction details
                    trailing: Text('10 Aug 2023'), // Replace with transaction date
                  );
                },
              ),
            ),

          ],
        ),
      ),
      bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
    );
  }
}


Widget _buildInfoItem(BuildContext context, String title, String value) => Expanded(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  ),
);
