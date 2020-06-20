import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/my_colors.dart';

class PhoneNumberInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        title: Text('Enter your phone number'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 20.00),
              //     child: Text(
              //       'Enter your phone number',
              //       style: TextStyle(
              //         color: MyColors.lightTealGreen,
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
