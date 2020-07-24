import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/services/firebase_auth_service.dart';
import 'package:whatsapp_clone_app/services/firestore_database.dart';

import '../../../utils/export_utils.dart';
import 'components/user_profile_pic.dart';

class ProfileInfoScreen extends StatefulWidget {
  final AuthCredential credential;
  final String countryCode;
  final String phoneNumber;

  const ProfileInfoScreen({
    Key key,
    @required this.credential,
    @required this.countryCode,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Profile info',
          style: TextStyle(color: MyColors.lightTealGreen),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildHelperText(context),
                SizedBox(height: 22.0),
                UserProfilePic(),
                SizedBox(height: 22.0),
                _buildNameInputField(),
              ],
            ),
            FlatButton(
              onPressed: () {
                String name = _nameController.text;
                FirebaseAuthService()
                    .signInWithCredential(widget.credential)
                    .then((AuthResult result) {
                  FirestoreDatabase().createUser(
                    user: result.user,
                    name: name,
                    countryCode: widget.countryCode,
                    phoneNumber: widget.phoneNumber,
                  );
                });
              },
              textColor: Colors.white,
              color: MyColors.lightGreen,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildNameInputField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Type your name here',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showToastMessage('Pressed');
          },
          child: Icon(
            Icons.sentiment_satisfied,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  FittedBox _buildHelperText(BuildContext context) {
    return FittedBox(
      child: Text(
        'Please provide you name and an optional profile photo.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: 14.0,
              color: MyColors.disabledColor,
            ),
      ),
    );
  }
}
