import 'package:flutter/material.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CircleAvatar(
      maxRadius: size.width * 0.15,
      backgroundImage: AssetImage('assets/images/default_user.png'),
    );
  }
}
