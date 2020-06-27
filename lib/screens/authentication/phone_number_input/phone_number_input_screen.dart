import 'package:flutter/material.dart';

import '../../../my_colors.dart';
import 'components/help_popup_menu_button.dart';
import 'components/helper_text_widget.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  @override
  _PhoneNumberInputScreenState createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: 'Choose a country');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Container(),
        title: FittedBox(
          child: Text(
            'Enter you phone number',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: MyColors.lightTealGreen),
          ),
        ),
        actions: <Widget>[
          HelpPopupMenuButton(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            HelperTextWidget(),
            Container(
              color: Colors.grey.shade100,
              width: size.width * 0.7,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.pie_chart_outlined,
                          color: Colors.transparent,
                        ), // the icon is just to center the textfeild
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _countryController,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              isDense: true,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add, size: 12.0),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                maxLength: 3,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  isDense: true,
                                  counterText: '',
                                  // border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                isDense: true, hintText: 'phone number'
                                // border: InputBorder.none,
                                ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
