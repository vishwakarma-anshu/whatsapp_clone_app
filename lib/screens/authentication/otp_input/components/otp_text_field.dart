import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../my_colors.dart';

class OTPTextField extends StatefulWidget {
  final String hintSymbol;
  final int digits;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;

  const OTPTextField({
    Key key,
    this.hintSymbol = '\u2014',
    this.digits = 6,
    this.obscureText = false,
    this.onChanged,
    this.onCompleted,
  }) : super(key: key);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textEditingControllers;

  List<String> _pin;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>(widget.digits);
    _textEditingControllers = List<TextEditingController>(widget.digits);

    _pin = List.generate(widget.digits, (int index) => '');
  }

  @override
  void dispose() {
    _textEditingControllers.forEach((textEditingController) {
      textEditingController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 150.0,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2.0,
            color: MyColors.lightTealGreen,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.digits + 1,
          (index) {
            if (index == 3) return SizedBox(width: 12.0);

            int _index = index > 3 ? index - 1 : index;

            if (_focusNodes[_index] == null) {
              _focusNodes[_index] = FocusNode();
            }

            if (_textEditingControllers[_index] == null) {
              _textEditingControllers[_index] = TextEditingController();
            }

            return Expanded(
              child: TextField(
                maxLength: 1,
                obscureText: widget.obscureText,
                controller: _textEditingControllers[_index],
                focusNode: _focusNodes[_index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  hintText: widget.hintSymbol,
                  border: InputBorder.none,
                  counterText: '',
                  isDense: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _pin[_index] = value;
                  });

                  if (value.isNotEmpty && _index + 1 != widget.digits) {
                    _focusNodes[_index].unfocus();
                    FocusScope.of(context)
                        .requestFocus(_focusNodes[_index + 1]);
                  }

                  if (value.isEmpty) {
                    _focusNodes[_index].unfocus();
                    _focusNodes[_index - 1].requestFocus();
                  }

                  String currentPin = '';
                  _pin.forEach((String digit) {
                    currentPin = currentPin + digit;
                  });

                  if (!_pin.contains(null) &&
                      !_pin.contains('') &&
                      currentPin.length == widget.digits) {
                    widget.onCompleted(currentPin);
                  }

                  widget.onChanged(currentPin);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
