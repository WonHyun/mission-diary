import 'package:flutter/material.dart';

class SelectorItem extends StatelessWidget {
  const SelectorItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.text,
    this.width = 70,
    this.height = 30,
  });

  final Function() onTap;
  final bool isSelected;
  final String text;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inverseSurface,
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
