import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone_app/my_colors.dart';

class PolicyAndTermsText extends StatefulWidget {
  const PolicyAndTermsText({
    Key key,
  }) : super(key: key);

  @override
  _PolicyAndTermsTextState createState() => _PolicyAndTermsTextState();
}

class _PolicyAndTermsTextState extends State<PolicyAndTermsText> {
  TapGestureRecognizer _policyTextGestureRecognizer;
  TapGestureRecognizer _termsTextGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _policyTextGestureRecognizer = TapGestureRecognizer()
      ..onTap = _launchPolicyDialog;

    _termsTextGestureRecognizer = TapGestureRecognizer()
      ..onTap = _launchTermsDialog;
  }

  @override
  void dispose() {
    _policyTextGestureRecognizer.dispose();
    _termsTextGestureRecognizer.dispose();
    super.dispose();
  }

  void _launchTermsDialog() {
    HapticFeedback.vibrate();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms of Services'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Anshu Vishwakarma cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.',
                  softWrap: true,
                ),
                Text(
                  '\nThe app is just a way to improve my flutter app developing skills. The code for the app is available on GitHub at https://github.com/vishwakarma-anshu/',
                  softWrap: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _launchPolicyDialog() {
    HapticFeedback.vibrate();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Private Policy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Anshu Vishwakarma built the WhatsApp Clone app as an Open Source app and to learn Flutter. This SERVICE is provided by Anshu Vishwakarma just for testing and way to improve the app and my skills as well. \n',
                  softWrap: true,
                ),
                Text(
                  'This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone. For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Phone Number. The information that I request will be retained on cloud database. The app does use third party services that may collect information used to identify you.\n\nThird Party Serive Providers used are : ',
                  softWrap: true,
                ),
                Text(
                    'Google Playstore Services \n Google Analytics for Firebase.'),
                Text(
                  '\n\nIf you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at query.anshu.asv@gmail.com.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        softWrap: true,
        text: TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Private Policy',
              style: TextStyle(
                color: MyColors.lightSkyBlue,
              ),
              recognizer: _policyTextGestureRecognizer,
            ),
            TextSpan(text: '. Tap "Agree and continue" to accept the '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: MyColors.lightSkyBlue,
              ),
              recognizer: _termsTextGestureRecognizer,
            ),
            TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
