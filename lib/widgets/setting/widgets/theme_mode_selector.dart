import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeModeSelector extends StatefulWidget {
  const ThemeModeSelector({
    super.key,
    required this.onThemeChanged,
    required this.currentThemeMode,
    this.width = 130,
    this.height = 40,
  });

  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentThemeMode;
  final double width;
  final double height;

  @override
  State<ThemeModeSelector> createState() => _ThemeModeSelectorState();
}

class _ThemeModeSelectorState extends State<ThemeModeSelector> {
  late Alignment _alignment = _getSelectorAlignment(widget.currentThemeMode);

  Alignment _getSelectorAlignment(ThemeMode themeMode) {
    switch (ThemeMode.values.indexOf(themeMode)) {
      case 0:
        return _alignment = Alignment.centerLeft;
      case 1:
        return _alignment = Alignment.center;
      case 2:
      default:
        return _alignment = Alignment.centerRight;
    }
  }

  Color _getSelectorColor(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Colors.grey.shade100;
      case ThemeMode.light:
        return Colors.amber.shade100;
      case ThemeMode.dark:
        return Colors.blue.shade100;
    }
  }

  void _onChangeSelector(ThemeMode themeMode) {
    setState(() {
      _alignment = _getSelectorAlignment(themeMode);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);
    const curve = Curves.easeInOut;
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            alignment: _alignment,
            duration: duration,
            curve: curve,
            child: AnimatedContainer(
              width: 40,
              height: 40,
              duration: duration,
              curve: curve,
              decoration: BoxDecoration(
                color: _getSelectorColor(widget.currentThemeMode),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...ThemeMode.values.map(
                (themeMode) => ThemeModeButton(
                  onPressed: () {
                    _onChangeSelector(themeMode);
                    widget.onThemeChanged(themeMode);
                  },
                  themeMode: themeMode,
                  isSelected: widget.currentThemeMode == themeMode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({
    super.key,
    required this.onPressed,
    required this.themeMode,
    required this.isSelected,
    this.size = 40,
  });

  final Function() onPressed;
  final ThemeMode themeMode;
  final bool isSelected;
  final double size;

  IconData _iconSelector(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return FontAwesomeIcons.gear;
      case ThemeMode.light:
        return FontAwesomeIcons.solidSun;
      case ThemeMode.dark:
        return FontAwesomeIcons.solidMoon;
    }
  }

  Color _colorSelector(
      BuildContext context, ThemeMode themeMode, bool isSelected) {
    switch (themeMode) {
      case ThemeMode.system:
        return isSelected
            ? Colors.grey
            : Theme.of(context).colorScheme.inverseSurface;
      case ThemeMode.light:
        return isSelected
            ? Colors.amber
            : Theme.of(context).colorScheme.inverseSurface;
      case ThemeMode.dark:
        return isSelected
            ? Colors.blue
            : Theme.of(context).colorScheme.inverseSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          _iconSelector(themeMode),
          color: _colorSelector(context, themeMode, isSelected),
          size: 22,
        ),
      ),
    );
  }
}
