import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insecure/core/constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

class LimitedTextWidget extends StatefulWidget {
  final String text;

  const LimitedTextWidget({super.key, required this.text});

  @override
  State<StatefulWidget> createState() => _LimitedTextWidgetState();
}

class _LimitedTextWidgetState extends State<LimitedTextWidget> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    // Check if the widget is still mounted before accessing context
    if (!mounted) return;

    final span = TextSpan(
      text: widget.text,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    final tp = TextPainter(
      maxLines: 2,
      text: span,
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    );

    tp.layout(maxWidth: MediaQuery.of(context).size.width);
    if (tp.didExceedMaxLines) {
      setState(() {
        _isOverflowing = true;
      });
    }
  }

  List<TextSpan> buildTextWithLinks(String text) {
    // Regular expression to find URLs
    final RegExp linkRegExp = RegExp(
      r"(https?:\/\/[^\s]+)", // Matches URLs starting with http or https
      caseSensitive: false,
    );

    List<TextSpan> spans = [];
    int currentIndex = 0;

    // Loop through all the matches
    for (final match in linkRegExp.allMatches(text)) {
      // Add any text before the match as a normal span
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
        ));
      }

      // Add the matched URL as a clickable link
      final String url = match.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: const TextStyle(
            color: Colors.blue, decoration: TextDecoration.underline),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final Uri urlS = Uri.parse(url);
            if (!await launchUrl(urlS)) throw 'Could not launch $urlS';
          },
      ));

      currentIndex = match.end;
    }

    // Add any remaining text after the last match
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
      ));
    }

    return spans;
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: _isExpanded ? Get.height : 60.0,
            ),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: buildTextWithLinks(widget.text),
              ),
              textAlign: TextAlign.start,
              maxLines: _isExpanded ? null : 3,
              overflow:
                  _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
        ),
        if (_isOverflowing)
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: TextButton(
              onPressed: _toggleExpand,
              child: Text(
                _isExpanded ? 'عرض اقل...' : 'عرض المزيد...',
                style:
                    TextStyle(fontSize: 13.spMin, color: AppColor.primaryColor),
              ),
            ),
          ),
      ],
    );
  }
}
