import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/color.dart';

class UserInfoTextField extends StatefulWidget {
  const UserInfoTextField({
    super.key,
    this.labelText,
    this.guideText,
    this.floatingLabelText,
    this.validator,
    this.onSaved,
    this.isEnabled = true,
    this.isObscure = false,
    this.textInputType = TextInputType.none,
    this.controller,
  });

  final String? labelText;
  final String? floatingLabelText;
  final String? guideText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool isEnabled;
  final bool isObscure;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  State<UserInfoTextField> createState() => _UserInfoTextFieldState();
}

class _UserInfoTextFieldState extends State<UserInfoTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _isShowObscure = false;

  bool _isOff() {
    if (widget.validator == null) return true;
    if (widget.validator!(widget.controller?.text) == null) {
      return false;
    } else {
      return true;
    }
  }

  String _getLabelText() {
    if (widget.labelText == null) return "";
    if (widget.floatingLabelText == null) return widget.labelText!;
    if (_hasFocus || (widget.controller?.text.isNotEmpty ?? false)) {
      return widget.floatingLabelText!;
    }
    return widget.labelText!;
  }

  void _toggleObscureText() => setState(() => _isShowObscure = !_isShowObscure);

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    _isShowObscure = widget.isObscure;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      enabled: widget.isEnabled,
      obscureText: _isShowObscure,
      focusNode: _focusNode,
      controller: widget.controller,
      onChanged: (value) => setState(() => widget.validator?.call(value)),
      validator: widget.validator,
      onSaved: widget.onSaved,
      style: const TextStyle(
        color: ThemeColors.primaryColor,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 10),
        label: Text(_getLabelText()),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        floatingLabelBehavior: widget.floatingLabelText == null
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        hintText: widget.guideText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
        ),
        suffix: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Offstage(
                offstage: !widget.isObscure,
                child: GestureDetector(
                  onTapDown: (details) => _toggleObscureText(),
                  onTapUp: (details) => _toggleObscureText(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FaIcon(
                      _isShowObscure
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.solidEye,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: _isOff(),
                child: AnimatedOpacity(
                  opacity: _isOff() ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  child: const FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: ThemeColors.verifyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
          ),
        ),
      ),
    );
  }
}
