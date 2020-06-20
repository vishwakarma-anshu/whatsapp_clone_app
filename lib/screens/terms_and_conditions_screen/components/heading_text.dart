import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/my_colors.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: Text(
          'Welcome to WhatsApp',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: MyColors.lightTealGreen,
          ),
        ),
      ),
    );
  }
}
