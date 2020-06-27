import 'package:flutter/material.dart';

import '../../../my_colors.dart';
import 'components/country_dropdown.dart';
import 'components/help_popup_menu_button.dart';
import 'components/helper_text_widget.dart';

class PhoneNumberInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Container(),
        title: FittedBox(
          child: Text(
            'Enter you phone number',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        actions: <Widget>[
          HelpPopupMenuButton(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              HelperTextWidget(),
              CountryDropdown(),
            ],
          ),
        ),
      ),
    );
  }
}
