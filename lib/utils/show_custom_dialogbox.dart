import 'package:flutter/material.dart';

import 'my_colors.dart';

void showCustomDialog(String content, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24.0),
        contentPadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            textColor: MyColors.lightGreen,
            child: Text('ok'.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
