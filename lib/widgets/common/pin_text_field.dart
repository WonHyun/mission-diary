import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({
    super.key,
    this.isEnabled = true,
    this.onSubmit,
  });

  final bool isEnabled;
  final Function(String)? onSubmit;

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  final int _pinLength = 6;
  late final List<FocusNode> _focusNodes =
      List.generate(_pinLength, (index) => FocusNode());
  late final List<TextEditingController> _controllers =
      List.generate(_pinLength, (index) => TextEditingController());

  // The cursor position always changes to the end of the text input,
  // even if the user taps on the first cursor position of the textField.
  void _addListenerToTextFieldFocusNodes() {
    for (int i = 0; i < _pinLength; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _controllers[i].selection = TextSelection.fromPosition(
            TextPosition(offset: _controllers[i].text.length),
          );
        }
      });
    }
  }

  void _handleFocus(String value, int index) {
    if (value.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    } else if (value.length > 1) {
      if (index < _pinLength - 1) {
        _controllers[index].text = value.substring(0, 1);
        _controllers[index + 1].text = value.substring(1, 2);
        _focusNodes[index + 1].requestFocus();
      } else if (index == _pinLength - 1) {
        _controllers[index].text = value.substring(1, 2);
      }
    }
    _checkPinInput();
  }

  void _checkPinInput() {
    final pin = _controllers.map((controller) => controller.text).join();
    if (pin.length == _pinLength) {
      widget.onSubmit?.call(pin);
    }
  }

  @override
  void initState() {
    super.initState();
    _addListenerToTextFieldFocusNodes();
    _focusNodes.first.requestFocus();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _pinLength,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 35,
              child: TextFormField(
                enabled: widget.isEnabled,
                focusNode: _focusNodes[index],
                controller: _controllers[index],
                showCursor: false,
                textAlign: TextAlign.center,
                onChanged: (value) => _handleFocus(value, index),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context)
                          .colorScheme
                          .inverseSurface
                          .withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context)
                          .colorScheme
                          .inverseSurface
                          .withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 16);
          },
        ),
      ),
    );
  }
}
