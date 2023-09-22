import 'package:delivery/common_utility/global_shared_prefences.dart';
import 'package:delivery/screens/CommonWidgets/user_enabled_bottom_message.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
    body: ListView.builder(
    itemCount: faqItems.length,
    itemBuilder: (context, index) {
      final faqItem = faqItems[index];
      final color = index % 2 == 0 ? Colors.lightBlue : Colors
          .lightGreen; // Alternate colors

      return Container(
        color: color,
        child: ExpansionTile(
          title: Text(faqItem.question, style: TextStyle(color: Colors.white)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                faqItem.answer,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }),
      // body: ListView(
      //   children: [
      //     for (var faqItem in faqItems)
      //       ExpansionTile(
      //         title: Text(faqItem.question),
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: Text(faqItem.answer),
      //           ),
      //         ],
      //       ),
      //   ],
      // ),
      bottomSheet: SharedPrefsValues.isAccountActivated=='Y' ? null: BottomSheetWidget(),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem(this.question, this.answer);
}

List<FaqItem> faqItems = [
  FaqItem(
    'What is Flutter?',
    'Flutter is an open-source UI software development kit created by Google.',
  ),
  FaqItem(
    'How do I get started with Flutter?',
    'To get started with Flutter, you need to install Flutter and Dart, set up an IDE like Android Studio or Visual Studio Code, and then create and run your first Flutter app.',
  ),
  // Add more FAQ items...
];
