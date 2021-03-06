import 'dart:core';

import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_cloud.dart';
import 'package:dart_rss/domain/rss_image.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_itunes.dart';

class RssFeed {
  final String? title;
  final String? author;
  final String? description;
  final String? link;
  final List<RssItem>? items;

  final RssImage? image;
  final RssCloud? cloud;
  final List<RssCategory>? categories;
  final List<String>? skipDays;
  final List<int?>? skipHours;
  final String? lastBuildDate;
  final String? language;
  final String? generator;
  final String? copyright;
  final String? docs;
  final String? managingEditor;
  final String? rating;
  final String? webMaster;
  final int? ttl;
  final DublinCore? dc;
  final RssItunes? itunes;

  RssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.image,
    this.cloud,
    this.categories,
    this.skipDays,
    this.skipHours,
    this.lastBuildDate,
    this.language,
    this.generator,
    this.copyright,
    this.docs,
    this.managingEditor,
    this.rating,
    this.webMaster,
    this.ttl,
    this.dc,
    this.itunes,
  });

  factory RssFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements("channel").first;
    } on StateError {
      throw ArgumentError("channel not found");
    }

    final cloudElement = findElementOrNull(channelElement, "cloud");
    final imageElement = findElementOrNull(channelElement, "image");

    return RssFeed(
      title: findElementOrNull(channelElement, "title")?.text,
      author: findElementOrNull(channelElement, "author")?.text,
      description: findElementOrNull(channelElement, "description")?.text,
      link: findElementOrNull(channelElement, "link")?.text,
      items: channelElement.findElements("item").map((element) {
        return RssItem.parse(element);
      }).toList(),
      image: imageElement != null ? RssImage.parse(imageElement) : null,
      cloud: cloudElement != null ? RssCloud.parse(cloudElement) : null,
      categories: channelElement.findElements("category").map((element) {
        return RssCategory.parse(element);
      }).toList(),
      skipDays: findElementOrNull(channelElement, "skipDays")
              ?.findAllElements("day")
              .map((element) {
            return element.text;
          }).toList() ??
          [],
      skipHours: findElementOrNull(channelElement, "skipHours")
              ?.findAllElements("hour")
              .map((element) {
            return int.tryParse(element.text);
          }).toList() ??
          [],
      lastBuildDate: findElementOrNull(channelElement, "lastBuildDate")?.text,
      language: findElementOrNull(channelElement, "language")?.text,
      generator: findElementOrNull(channelElement, "generator")?.text,
      copyright: findElementOrNull(channelElement, "copyright")?.text,
      docs: findElementOrNull(channelElement, "docs")?.text,
      managingEditor: findElementOrNull(channelElement, "managingEditor")?.text,
      rating: findElementOrNull(channelElement, "rating")?.text,
      webMaster: findElementOrNull(channelElement, "webMaster")?.text,
      ttl: int.tryParse(findElementOrNull(channelElement, "ttl")?.text ?? "0"),
      dc: DublinCore.parse(channelElement),
      itunes: RssItunes.parse(channelElement),
    );
  }
}
