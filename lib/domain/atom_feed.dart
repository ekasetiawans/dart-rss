import 'package:dart_rss/domain/atom_category.dart';
import 'package:dart_rss/domain/atom_generator.dart';
import 'package:dart_rss/domain/atom_item.dart';
import 'package:dart_rss/domain/atom_link.dart';
import 'package:dart_rss/domain/atom_person.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomFeed {
  final String? id;
  final String? title;
  final String? updated;
  final List<AtomItem>? items;

  final List<AtomLink>? links;
  final List<AtomPerson>? authors;
  final List<AtomPerson>? contributors;
  final List<AtomCategory>? categories;
  final AtomGenerator? generator;
  final String? icon;
  final String? logo;
  final String? rights;
  final String? subtitle;

  AtomFeed({
    this.id,
    this.title,
    this.updated,
    this.items,
    this.links,
    this.authors,
    this.contributors,
    this.categories,
    this.generator,
    this.icon,
    this.logo,
    this.rights,
    this.subtitle,
  });

  factory AtomFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    XmlElement feedElement;
    try {
      feedElement = document.findElements("feed").first;
    } on StateError {
      throw new ArgumentError("feed not found");
    }

    final generatorElement = findElementOrNull(feedElement, "generator");
    return AtomFeed(
      id: findElementOrNull(feedElement, "id")?.text,
      title: findElementOrNull(feedElement, "title")?.text,
      updated: findElementOrNull(feedElement, "updated")?.text,
      items: feedElement.findElements("entry").map((element) {
        return AtomItem.parse(element);
      }).toList(),
      links: feedElement.findElements("link").map((element) {
        return AtomLink.parse(element);
      }).toList(),
      authors: feedElement.findElements("author").map((element) {
        return AtomPerson.parse(element);
      }).toList(),
      contributors: feedElement.findElements("contributor").map((element) {
        return AtomPerson.parse(element);
      }).toList(),
      categories: feedElement.findElements("category").map((element) {
        return AtomCategory.parse(element);
      }).toList(),
      generator: generatorElement != null
          ? AtomGenerator.parse(generatorElement)
          : null,
      icon: findElementOrNull(feedElement, "icon")?.text,
      logo: findElementOrNull(feedElement, "logo")?.text,
      rights: findElementOrNull(feedElement, "rights")?.text,
      subtitle: findElementOrNull(feedElement, "subtitle")?.text,
    );
  }
}
