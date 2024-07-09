import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/color.dart';
import 'package:mission_diary/global/sizes.dart';

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
    this.inputTextColor,
    this.prefixIcon,
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
  final Color? inputTextColor;
  final IconData? prefixIcon;

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
      style: TextStyle(
        color: widget.inputTextColor,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: Sizes.size10),
        label: Text(_getLabelText()),
        labelStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: Sizes.size18,
          fontWeight: FontWeight.w300,
        ),
        floatingLabelBehavior: widget.floatingLabelText == null
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        hintText: widget.guideText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade400,
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
                    color: ThemeColors.lightGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: Sizes.size14),
                child: Icon(
                  widget.prefixIcon,
                  color: Colors.grey.shade600,
                  size: Sizes.size20,
                ),
              )
            : null,
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
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
