import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/my_colors.dart';

class WhatsAppCloneLogo extends StatelessWidget {
  const WhatsAppCloneLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          width: MediaQuery.of(context).size.width / 1.6,
          color: MyColors.lightGreen,
          image: AssetImage('assets/images/brand.png'),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            alignment: Alignment.center,
            height: 40.0,
            width: 70.0,
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Container(
                height: 33.0,
                width: 63.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColors.lightGreen,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  'Clone',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
