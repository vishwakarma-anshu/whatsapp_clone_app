import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing..'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String verificationId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildTextField(
            label: 'Phone Number',
            onSubmitted: (value) {
              verifyPhoneNumber(value, context);
            },
          ),
          _buildTextField(
              label: 'OTP',
              onSubmitted: (value) {
                if (value.trim().length == 6) {
                  var credential = PhoneAuthProvider.getCredential(
                      verificationId: verificationId, smsCode: value);

                  if (verificationId != null) {
                    signin(credential, context);
                  } else {
                    showSnackBar(context, 'VerificationId not set');
                  }
                }
              }),
        ],
      ),
    );
  }

  TextField _buildTextField({String label, Function onSubmitted}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      onSubmitted: onSubmitted,
    );
  }

  void verifyPhoneNumber(String phoneNumber, BuildContext context) {
    void _verified(AuthCredential credential) {
      signin(credential, context);
    }

    void _failed(AuthException exception) {
      showSnackBar(context, '${exception.message}');
    }

    void _smsSend(String verificationId, [int forecedId]) {
      this.verificationId = verificationId;
      showSnackBar(context, 'Enter the otp');
    }

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 30),
      verificationCompleted: _verified,
      verificationFailed: _failed,
      codeSent: _smsSend,
      codeAutoRetrievalTimeout: null,
    );
  }

  void signin(AuthCredential credential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if (value != null) {
        showSnackBar(context,
            'User with phone number ${value.user.phoneNumber} verified and signed in');
      }
    });
  }

  void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
