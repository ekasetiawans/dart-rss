import 'package:dart_rss/domain/rss_content.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'dublin_core/dublin_core.dart';

class Rss1Item {
  final String? title;
  final String? description;
  final String? link;
  final DublinCore? dc;
  final RssContent? content;

  Rss1Item({
    this.title,
    this.description,
    this.link,
    this.dc,
    this.content,
  });

  factory Rss1Item.parse(XmlElement element) {
    final contentElement = findElementOrNull(element, "content:encoded");
    return Rss1Item(
      title: findElementOrNull(element, "title")?.text,
      description: findElementOrNull(element, "description")?.text,
      link: findElementOrNull(element, "link")?.text,
      dc: DublinCore.parse(element),
      content: contentElement != null ? RssContent.parse(contentElement) : null,
    );
  }
}
