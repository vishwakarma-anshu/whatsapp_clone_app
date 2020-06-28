import 'package:flutter/material.dart';

class OtpInputScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpInputScreen({
    Key key,
    @required this.phoneNumber,
  })  : assert(phoneNumber != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(phoneNumber),
      ),
    );
  }
}
