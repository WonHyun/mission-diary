import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 30,
    this.leading,
    this.text,
    this.fontColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.isActive = true,
    this.borderColor,
    this.backgroundColor,
    this.inactiveColor,
    this.inactiveFontColor,
    this.centerWidget,
    this.onTap,
  });

  final double width;
  final double height;
  final double borderRadius;
  final Widget? leading;
  final String? text;
  final Color? fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isActive;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? inactiveColor;
  final Color? inactiveFontColor;
  final Widget? centerWidget;
  final Function()? onTap;

  Color _setBackgroundColor(BuildContext context) {
    if (isActive) {
      return backgroundColor ?? Theme.of(context).colorScheme.surface;
    } else {
      return inactiveColor ?? Colors.grey.shade600;
    }
  }

  Color _setFontColor(BuildContext context) {
    if (isActive) {
      return fontColor ?? Theme.of(context).colorScheme.inverseSurface;
    } else {
      return inactiveFontColor ?? Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _setBackgroundColor(context),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 0.5,
          color: borderColor ?? Colors.grey.shade500,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isActive ? onTap : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading ?? const SizedBox.shrink(),
              if (leading != null) const SizedBox(width: 15),
              centerWidget ??
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: _setFontColor(context),
                    ),
                    child: Text(text ?? ""),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
