import 'package:flutter/material.dart';

class LinkedText extends StatefulWidget {
  const LinkedText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w300,
    this.color = Colors.blue,
    this.onTap,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Function()? onTap;

  @override
  State<LinkedText> createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  bool _isTapping = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) => setState(() => _isTapping = true),
      onTapUp: (details) => setState(() => _isTapping = false),
      onTapCancel: () => setState(() => _isTapping = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 100),
        style: TextStyle(
          color: _isTapping ? widget.color.withOpacity(0.4) : widget.color,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
