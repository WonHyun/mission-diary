import 'package:flutter/material.dart';

class SelectorItem extends StatelessWidget {
  const SelectorItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.text,
    this.width = 70,
    this.height = 30,
    this.isActive = true,
  });

  final Function() onTap;
  final bool isSelected;
  final String text;
  final double? width;
  final double? height;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isActive
                ? isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.inverseSurface
                : Colors.grey,
          ),
          color: isSelected
              ? isActive
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey
              : Theme.of(context).colorScheme.surface,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : isActive
                    ? Theme.of(context).colorScheme.inverseSurface
                    : Colors.grey,
          ),
        ),
      ),
    );
  }
}
