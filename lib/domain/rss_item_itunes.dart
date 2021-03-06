import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_itunes_category.dart';
import 'rss_itunes_episode_type.dart';
import 'rss_itunes_image.dart';

class RssItemItunes {
  final String? title;
  final int? episode;
  final int? season;
  final Duration? duration;
  final RssItunesEpisodeType? episodeType;
  final String? author;
  final String? summary;
  final bool? explicit;
  final String? subtitle;
  final List<String>? keywords;
  final RssItunesImage? image;
  final RssItunesCategory? category;
  final bool? block;

  RssItemItunes({
    this.title,
    this.episode,
    this.season,
    this.duration,
    this.episodeType,
    this.author,
    this.summary,
    this.explicit,
    this.subtitle,
    this.keywords,
    this.image,
    this.category,
    this.block,
  });

  factory RssItemItunes.parse(XmlElement element) {
    var episodeStr = findElementOrNull(element, "itunes:episode")?.text.trim();
    var seasonStr = findElementOrNull(element, "itunes:season")?.text.trim();
    var durationStr =
        findElementOrNull(element, "itunes:duration")?.text.trim();

    final categoryElement = findElementOrNull(element, "itunes:category");
    final imageElement = findElementOrNull(element, "itunes:image");

    return RssItemItunes(
      title: findElementOrNull(element, "itunes:title")?.text.trim(),
      episode: episodeStr == null ? null : int.tryParse(episodeStr),
      season: seasonStr == null ? null : int.tryParse(seasonStr),
      duration: durationStr == null ? null : parseDuration(durationStr),
      episodeType: newRssItunesEpisodeType(
          findElementOrNull(element, "itunes:episodeType")),
      author: findElementOrNull(element, "itunes:author")?.text.trim(),
      summary: findElementOrNull(element, "itunes:summary")?.text.trim(),
      explicit: parseBoolLiteral(element, "itunes:explicit"),
      subtitle: findElementOrNull(element, "itunes:subtitle")?.text.trim(),
      keywords: findElementOrNull(element, "itunes:keywords")
          ?.text
          .split(",")
          .map((keyword) => keyword.trim())
          .toList(),
      image: imageElement != null ? RssItunesImage.parse(imageElement) : null,
      category: categoryElement != null
          ? RssItunesCategory.parse(categoryElement)
          : null,
      block: parseBoolLiteral(element, "itunes:block"),
    );
  }
}

Duration parseDuration(String s) {
  var hours = 0;
  var minutes = 0;
  var seconds = 0;
  var parts = s.split(':');
  if (parts.length > 2) {
    hours = int.tryParse(parts[parts.length - 3]) ?? 0;
  }
  if (parts.length > 1) {
    minutes = int.tryParse(parts[parts.length - 2]) ?? 0;
  }
  seconds = int.tryParse(parts[parts.length - 1]) ?? 0;
  return Duration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}
