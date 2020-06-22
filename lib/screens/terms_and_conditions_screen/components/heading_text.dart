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
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(
          'Welcome to WhatsApp',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: MyColors.lightTealGreen),
        ),
      ),
    );
  }
}
