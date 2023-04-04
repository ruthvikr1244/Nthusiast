
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SingleLineMarkdownBody extends MarkdownWidget {
  final TextOverflow overflow;
  final int maxLines;

  const SingleLineMarkdownBody(
      {Key? key,
      required String data,
      MarkdownStyleSheet? styleSheet,
      SyntaxHighlighter? syntaxHighlighter,
      MarkdownTapLinkCallback? onTapLink,
      String? imageDirectory,
      required this.overflow,
      required this.maxLines})
      : super(
          key: key,
          data: data,
          styleSheet: styleSheet,
          syntaxHighlighter: syntaxHighlighter,
          onTapLink: onTapLink,
          imageDirectory: imageDirectory,
        );

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    var richText = _findWidgetOfType<RichText>(children!.first);
    return RichText(
        text: richText!.text,
        textAlign: richText.textAlign,
        textDirection: richText.textDirection,
        softWrap: richText.softWrap,
        overflow: overflow,
        textScaleFactor: richText.textScaleFactor,
        maxLines: maxLines,
        locale: richText.locale);
  }

  T? _findWidgetOfType<T>(Widget widget) {
    if (widget is T) {
      return widget as T;
    }

    if (widget is MultiChildRenderObjectWidget) {
      MultiChildRenderObjectWidget multiChild = widget;
      for (var child in multiChild.children) {
        return _findWidgetOfType<T>(child);
      }
    } else if (widget is SingleChildRenderObjectWidget) {
      SingleChildRenderObjectWidget singleChild = widget;
      return _findWidgetOfType<T>(singleChild.child!);
    }

    return null;
  }
}
