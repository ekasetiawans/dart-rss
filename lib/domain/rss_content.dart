import 'package:xml/xml.dart';

final _imagesRegExp = new RegExp(
  "<img\\s.*?src=(?:'|\")([^'\">]+)(?:'|\")",
  multiLine: true,
  caseSensitive: false,
);

/// For RSS Content Module:
///
/// - `xmlns:content="http://purl.org/rss/1.0/modules/content/"`
///
class RssContent {
  String value;
  Iterable<String?> images;

  RssContent(this.value, this.images);

  factory RssContent.parse(XmlElement element) {
    final content = element.text;
    final images = <String?>[];
    _imagesRegExp.allMatches(content).forEach((match) {
      images.add(match.group(1));
    });
    return RssContent(content, images);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RssContent &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          images == other.images;

  @override
  int get hashCode => value.hashCode ^ images.hashCode;
}
