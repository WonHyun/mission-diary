import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mission_diary/widgets/common/linked_text.dart';

import 'package:url_launcher/url_launcher.dart';

class PolicyGuideText extends StatelessWidget {
  const PolicyGuideText({
    super.key,
    required this.mdText,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w300,
    this.fontColor,
    this.linkColor,
  });

  final double fontSize;
  final FontWeight fontWeight;
  final Color? fontColor;
  final Color? linkColor;
  final String mdText;

  Future<void> _onTapUrl(String url) async {
    try {
      final parsedUrl = Uri.parse(url);
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  List<InlineSpan> parse(String text) {
    List<InlineSpan> spans = [];
    final RegExp exp = RegExp(r'\[([^\]]+)\]\(([^)]+)\)');
    int lastMatchEnd = 0;

    for (final Match match in exp.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final String linkText = match.group(1)!;
      final String linkUrl = match.group(2)!;

      spans.add(
        WidgetSpan(
          child: LinkedText(
            text: linkText,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: linkColor ?? Colors.blue,
            onTap: () => _onTapUrl(linkUrl),
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: fontColor ?? Theme.of(context).colorScheme.inverseSurface,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: 1.3,
        ),
        children: parse(mdText),
      ),
    );
  }
}
