import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/help_popup_menu_button.dart';
import '../../../utils/export_utils.dart';
import '../profile_info/profile_info_screen.dart';
import 'components/otp_helper_text_widget.dart';
import 'components/otp_text_field.dart';

class OtpInputScreen extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String verificationId;

  const OtpInputScreen({
    Key key,
    @required this.phoneNumber,
    @required this.countryCode,
    @required this.verificationId,
  })  : assert(phoneNumber != null),
        super(key: key);

  @override
  _OtpInputScreenState createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  String errorText =
      'The code you entered is incorrent.\nPlease try again in 2 seconds.';

  List<FocusNode> _focusNodes;
  List<TextEditingController> _textEditingControllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _textEditingControllers =
        List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    _textEditingControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          OTPHelperTextWidget(phoneNumber: widget.phoneNumber),
          SizedBox(height: 18.0),
          OTPTextField(
            otpDigitControllers: _textEditingControllers,
            otpFocusNodes: _focusNodes,
            hintSymbol: '\u2014',
            onChanged: (String value) {
              print(value);
            },
            onCompleted: (String value) {
              bool verified = verifyUser(value);
              if (!verified) {
                showCustomDialog(
                    'Something went wrong!!, Please enter the otp again.',
                    context);
              }
            },
          ),
          SizedBox(height: 12.0),
          Text(
            'Enter 6-digit code',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          _buildResendOption(Icons.message, 'Resend SMS'),
          Divider(height: 0.0),
          _buildResendOption(Icons.call, 'Call me'),
        ],
      ),
    );
  }

  ListTile _buildResendOption(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 32.0,
      ),
      leading: Icon(
        icon,
        color: MyColors.disabledColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        '1.05',
        style: TextStyle(color: MyColors.disabledColor),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: Container(),
      title: FittedBox(
        child: Text(
          'Verify ${widget.phoneNumber}',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: MyColors.lightTealGreen),
        ),
      ),
      actions: <Widget>[
        HelpPopupMenuButton(),
      ],
    );
  }

  void _resetOTP() {
    _focusNodes[5].unfocus();
    _focusNodes[0].requestFocus();
    _textEditingControllers.forEach((controller) {
      controller.text = '';
    });
  }

  bool verifyUser(String otp) {
    var credential = PhoneAuthProvider.getCredential(
        verificationId: widget.verificationId, smsCode: otp);

    if (credential != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileInfoScreen(
            credential: credential,
            countryCode: widget.countryCode,
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
      return true;
    } else {
      _resetOTP();
      return false;
    }
  }
}
