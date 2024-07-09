import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/sizes.dart';

class NavigatorMenuIcon extends StatelessWidget {
  const NavigatorMenuIcon({
    super.key,
    required this.onTap,
    required this.unselectedIcon,
    required this.selectedIcon,
    this.isSelected = false,
    this.size = Sizes.size24,
  });

  final Function() onTap;
  final IconData unselectedIcon;
  final IconData selectedIcon;
  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.5),
              size: isSelected ? size - Sizes.size2 : size - Sizes.size5,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(top: isSelected ? Sizes.size5 : 0),
              width: isSelected ? Sizes.size5 : 0,
              height: isSelected ? Sizes.size5 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
