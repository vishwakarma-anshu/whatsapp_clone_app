import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone_app/utils/phone_number_formatter.dart';

import '../../../components/country_code_list.dart';
import '../../../models/country.dart';
import '../../../my_colors.dart';
import 'components/help_popup_menu_button.dart';
import 'components/helper_text_widget.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  @override
  _PhoneNumberInputScreenState createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  TextEditingController _countryController;
  TextEditingController _codeController;
  TextEditingController _phoneNumberController;

  FocusNode _codeFocusNode;
  FocusNode _phoneNumberFocusNode;

  double _countryBorderWidth = 1.2;
  double _codeBorderWidth = 1.2;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: 'Choose a country');
    _codeController = TextEditingController();
    _phoneNumberController = TextEditingController();

    _codeFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _countryController.dispose();
    _codeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _updateCodeAndCountry(dynamic element) {
    if (element != null) {
      if (element is Country) {
        _countryController.text = element.name;
        _codeController.text = element.dialingCode;

        FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
      } else {
        if (element == '') {
          _countryController.text = 'Choose a country';
          setState(() {});
          return;
        }
        int index = countries
            .indexWhere((Country country) => country.dialingCode == element);
        if (index != -1) {
          _countryController.text = countries[index].name;

          FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
        } else {
          _countryController.text = 'invalid country code';
          setState(() {});
        }
      }
    }
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
                  Focus(
                    onFocusChange: (bool hasFocus) {
                      if (hasFocus) {
                        _countryBorderWidth = 1.8;
                      } else {
                        _countryBorderWidth = 1.2;
                      }
                    },
                    child: Container(
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
                              onTap: () async {
                                Country country = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryCodeList(),
                                  ),
                                );
                                _updateCodeAndCountry(country);
                              },
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: _countryBorderWidth,
                            color: MyColors.lightTealGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Focus(
                          onFocusChange: (bool hasFocus) {
                            if (hasFocus) {
                              _codeBorderWidth = 1.8;
                              setState(() {});
                            } else {
                              _codeBorderWidth = 1.2;
                              setState(() {});
                            }
                          },
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add, size: 12.0),
                                Expanded(
                                  child: TextField(
                                    controller: _codeController,
                                    focusNode: _codeFocusNode,
                                    textAlign: TextAlign.center,
                                    maxLength: 3,
                                    keyboardType: TextInputType.phone,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      counterText: '',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (String value) {
                                      _updateCodeAndCountry(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: _codeBorderWidth,
                                  color: MyColors.lightTealGreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                          flex: 5,
                          child: TextField(
                            controller: _phoneNumberController,
                            focusNode: _phoneNumberFocusNode,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(15),
                              PhoneNumberFormatter(),
                              // TODO: The PhoneNumberFormatter() is giving some problems
                              // TODO: The Terms&Condition Page shows Overflow error if keyboard gets displayed on it.
                            ],
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
