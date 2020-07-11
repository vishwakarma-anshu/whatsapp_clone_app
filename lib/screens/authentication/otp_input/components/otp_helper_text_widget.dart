import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../my_colors.dart';

class OTPHelperTextWidget extends StatefulWidget {
  final String phoneNumber;
  const OTPHelperTextWidget({
    Key key,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  _OTPHelperTextWidgetState createState() => _OTPHelperTextWidgetState();
}

class _OTPHelperTextWidgetState extends State<OTPHelperTextWidget> {
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            height: 1.4,
          ),
          text: 'Waiting to automatically detect an SMS send to ',
          children: <TextSpan>[
            TextSpan(
              text: '${widget.phoneNumber}. ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'Wrong number ?',
              style: TextStyle(color: MyColors.lightSkyBlue),
              recognizer: _tapGestureRecognizer,
            ),
          ],
        ),
      ),
    );
  }
}
