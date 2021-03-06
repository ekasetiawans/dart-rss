import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_content.dart';
import 'package:dart_rss/domain/rss_enclosure.dart';
import 'package:dart_rss/domain/rss_source.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_item_itunes.dart';

class RssItem {
  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory>? categories;
  final String? guid;
  final String? pubDate;
  final String? author;
  final String? comments;
  final RssSource? source;
  final RssContent? content;
  final Media? media;
  final RssEnclosure? enclosure;
  final DublinCore? dc;
  final RssItemItunes? itunes;

  RssItem({
    this.title,
    this.description,
    this.link,
    this.categories,
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
    this.enclosure,
    this.dc,
    this.itunes,
  });

  factory RssItem.parse(XmlElement element) {
    final encodedElement = findElementOrNull(element, "content:encoded");
    final enclosureElement = findElementOrNull(element, "enclosure");
    final sourceElement = findElementOrNull(element, "source");

    return RssItem(
      title: findElementOrNull(element, "title")?.text,
      description: findElementOrNull(element, "description")?.text,
      link: findElementOrNull(element, "link")?.text,
      categories: element.findElements("category").map((element) {
        return RssCategory.parse(element);
      }).toList(),
      guid: findElementOrNull(element, "guid")?.text,
      pubDate: findElementOrNull(element, "pubDate")?.text,
      author: findElementOrNull(element, "author")?.text,
      comments: findElementOrNull(element, "comments")?.text,
      source: sourceElement != null ? RssSource.parse(sourceElement) : null,
      content: encodedElement != null ? RssContent.parse(encodedElement) : null,
      media: Media.parse(element),
      enclosure: enclosureElement != null
          ? RssEnclosure.parse(enclosureElement)
          : null,
      dc: DublinCore.parse(element),
      itunes: RssItemItunes.parse(element),
    );
  }
}
