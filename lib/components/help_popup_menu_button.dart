import 'package:flutter/material.dart';

class HelpPopupMenuButton extends StatelessWidget {
  const HelpPopupMenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black54,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          child: Text('Help'),
        ),
      ],
    );
  }
}
