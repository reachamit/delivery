import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CommonWidgets/customTextView.dart';
import 'CommonWidgets/coming_soon_widget.dart';
import 'attandance.dart';

class LatestEventUpdateUI extends StatelessWidget {
  const LatestEventUpdateUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Attandance()),
            );
          },
        ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Attandance()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 1)),
                // Emit a new value every second
                builder: (context, snapshot) {
                  // Create a DateTime object with the current time
                  DateTime now = DateTime.now();

                  return comingSoonView(); // Your comingSoonView widget
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: DateFormat('h:mm')
                                .format(DateTime.now())
                                .toString(),
                            textSize: 90,
                            fontFamily: FontFamily.alumniSansRegular,
                            color: Colors.red,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CustomText(
                              text: DateFormat('a')
                                  .format(DateTime.now())
                                  .toString(),
                              textSize: 14,
                              fontFamily: FontFamily.alumniSansRegular,
                              color: Colors.black45,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
