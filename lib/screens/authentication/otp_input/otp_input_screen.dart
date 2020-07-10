import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/screens/authentication/otp_input/components/otp_helper_text_widget.dart';

import '../../../components/help_popup_menu_button.dart';
import '../../../my_colors.dart';

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
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            OTPHelperTextWidget(phoneNumber: phoneNumber),
            SizedBox(height: 12.0),
            Container(
              height: 30.0,
              width: 150.0,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '--- ---',
                  hintStyle: TextStyle(
                      // fontSize: 50.0,
                      // height: 30.0,
                      ),
                ),
              ),
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
          'Verify $phoneNumber',
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
}
