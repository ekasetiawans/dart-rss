import 'package:dart_rss/domain/media/star_rating.dart';
import 'package:dart_rss/domain/media/statistics.dart';
import 'package:dart_rss/domain/media/tags.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Community {
  final StarRating? starRating;
  final Statistics? statistics;
  final Tags? tags;

  Community({
    this.starRating,
    this.statistics,
    this.tags,
  });

  factory Community.parse(XmlElement element) {
    final tagsElement = findElementOrNull(element, "media:tags");
    return new Community(
      starRating: new StarRating.parse(
        findElementOrNull(element, "media:starRating")!,
      ),
      statistics: new Statistics.parse(
        findElementOrNull(element, "media:statistics")!,
      ),
      tags: tagsElement != null ? new Tags.parse(tagsElement) : null,
    );
  }
}
