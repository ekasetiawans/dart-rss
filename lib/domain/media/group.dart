import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content>? contents;
  final List<Credit>? credits;
  final Category? category;
  final Rating? rating;

  Group({
    this.contents,
    this.credits,
    this.category,
    this.rating,
  });

  factory Group.parse(XmlElement element) {
    final categoryElement = findElementOrNull(element, "media:category");
    final ratingElement = findElementOrNull(element, "media:rating");

    return new Group(
      contents: element.findElements("media:content").map((e) {
        return new Content.parse(e);
      }).toList(),
      credits: element.findElements("media:credit").map((e) {
        return new Credit.parse(e);
      }).toList(),
      category: categoryElement != null
          ? new Category.parse(
              categoryElement,
            )
          : null,
      rating: ratingElement != null ? new Rating.parse(ratingElement) : null,
    );
  }
}
