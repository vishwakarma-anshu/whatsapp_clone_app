import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone_app/utils/my_colors.dart';

import '../models/country.dart';
import '../utils/phone_number_formatter.dart';
import 'country_code_list.dart';

class CountryCodeAndPhoneNumberWidget extends StatefulWidget {
  const CountryCodeAndPhoneNumberWidget({
    Key key,
    @required this.size,
    @required this.countryController,
    @required this.codeController,
    @required this.codeFocusNode,
    @required this.phoneNumberController,
    @required this.phoneNumberFocusNode,
  }) : super(key: key);

  final Size size;
  final TextEditingController countryController;
  final TextEditingController codeController;
  final FocusNode codeFocusNode;
  final TextEditingController phoneNumberController;
  final FocusNode phoneNumberFocusNode;

  @override
  _CountryCodeAndPhoneNumberWidgetState createState() =>
      _CountryCodeAndPhoneNumberWidgetState();
}

class _CountryCodeAndPhoneNumberWidgetState
    extends State<CountryCodeAndPhoneNumberWidget> {
  double countryBorderWidth = 1.2;
  double codeBorderWidth = 1.2;

  void _updateCodeAndCountry(dynamic element) {
    if (element != null) {
      if (element is Country) {
        widget.countryController.text = element.name;
        widget.codeController.text = element.dialingCode;

        FocusScope.of(context).requestFocus(widget.phoneNumberFocusNode);
      } else {
        if (element == '') {
          widget.countryController.text = 'Choose a country';
          setState(() {});
          return;
        }
        int index = countries
            .indexWhere((Country country) => country.dialingCode == element);
        if (index != -1) {
          widget.countryController.text = countries[index].name;

          FocusScope.of(context).requestFocus(widget.phoneNumberFocusNode);
        } else {
          widget.countryController.text = 'invalid country code';
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade100,
      width: widget.size.width * 0.7,
      child: Column(
        children: <Widget>[
          _buildCountryField(context),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              _buildCodeTextField(),
              SizedBox(width: 12.0),
              _buildPhoneNumberTextField(),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildPhoneNumberTextField() {
    return Expanded(
      flex: 5,
      child: TextField(
        controller: widget.phoneNumberController,
        focusNode: widget.phoneNumberFocusNode,
        keyboardType: TextInputType.phone,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15),
          PhoneNumberFormatter(),
        ],
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'phone number',
        ),
        onChanged: (String value) {},
      ),
    );
  }

  Expanded _buildCodeTextField() {
    return Expanded(
      flex: 2,
      child: Focus(
        onFocusChange: (bool hasFocus) {
          if (hasFocus) {
            codeBorderWidth = 1.8;
            setState(() {});
          } else {
            codeBorderWidth = 1.2;
            setState(() {});
          }
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.add, size: 12.0),
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: widget.codeController,
                  focusNode: widget.codeFocusNode,
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
                width: codeBorderWidth,
                color: MyColors.lightTealGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryField(BuildContext context) => Focus(
        onFocusChange: (bool hasFocus) {
          if (hasFocus) {
            countryBorderWidth = 1.8;
          } else {
            countryBorderWidth = 1.2;
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
                  controller: widget.countryController,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
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
                width: countryBorderWidth,
                color: MyColors.lightTealGreen,
              ),
            ),
          ),
        ),
      );
}
