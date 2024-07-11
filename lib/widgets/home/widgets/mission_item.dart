import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';

class MissionItem extends StatelessWidget {
  const MissionItem({
    super.key,
    // required this.mission,
  });

  // final Mission mission;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) => {},
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Study Well",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            padding: const EdgeInsets.all(Sizes.size5),
                            iconSize: Sizes.size12,
                            color: Colors.grey.shade600,
                            onPressed: () => {},
                            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                          ),
                        ],
                      ),
                      Gaps.v5,
                      Text(
                        "07:00 ~ 07:15",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
