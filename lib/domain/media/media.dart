import 'package:dart_rss/domain/media/category.dart';
import 'package:dart_rss/domain/media/community.dart';
import 'package:dart_rss/domain/media/content.dart';
import 'package:dart_rss/domain/media/copyright.dart';
import 'package:dart_rss/domain/media/credit.dart';
import 'package:dart_rss/domain/media/description.dart';
import 'package:dart_rss/domain/media/embed.dart';
import 'package:dart_rss/domain/media/group.dart';
import 'package:dart_rss/domain/media/hash.dart';
import 'package:dart_rss/domain/media/license.dart';
import 'package:dart_rss/domain/media/peer_link.dart';
import 'package:dart_rss/domain/media/player.dart';
import 'package:dart_rss/domain/media/price.dart';
import 'package:dart_rss/domain/media/rating.dart';
import 'package:dart_rss/domain/media/restriction.dart';
import 'package:dart_rss/domain/media/rights.dart';
import 'package:dart_rss/domain/media/scene.dart';
import 'package:dart_rss/domain/media/status.dart';
import 'package:dart_rss/domain/media/text.dart';
import 'package:dart_rss/domain/media/thumbnail.dart';
import 'package:dart_rss/domain/media/title.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Media {
  final Group? group;
  final List<Content>? contents;
  final List<Credit>? credits;
  final Category? category;
  final Rating? rating;
  final Title? title;
  final Description? description;
  final String? keywords;
  final List<Thumbnail>? thumbnails;
  final Hash? hash;
  final Player? player;
  final Copyright? copyright;
  final Text? text;
  final Restriction? restriction;
  final Community? community;
  final List<String>? comments;
  final Embed? embed;
  final List<String>? responses;
  final List<String>? backLinks;
  final Status? status;
  final List<Price>? prices;
  final License? license;
  final PeerLink? peerLink;
  final Rights? rights;
  final List<Scene>? scenes;

  Media({
    this.group,
    this.contents,
    this.credits,
    this.category,
    this.rating,
    this.title,
    this.description,
    this.keywords,
    this.thumbnails,
    this.hash,
    this.player,
    this.copyright,
    this.text,
    this.restriction,
    this.community,
    this.comments,
    this.embed,
    this.responses,
    this.backLinks,
    this.status,
    this.prices,
    this.license,
    this.peerLink,
    this.rights,
    this.scenes,
  });

  factory Media.parse(XmlElement element) {
    final groupElement = findElementOrNull(element, "media:group");
    final categoryElement = findElementOrNull(element, "media:category");
    final ratingElement = findElementOrNull(element, "media:rating");
    final titleElement = findElementOrNull(element, "media:title");
    final descriptionElement = findElementOrNull(element, "media:description");
    final hashElement = findElementOrNull(element, "media:hash");
    final playerElement = findElementOrNull(element, "media:player");
    final copyrightElement = findElementOrNull(element, "media:copyright");
    final textElement = findElementOrNull(element, "media:text");
    final restrictionElement = findElementOrNull(element, "media:restriction");
    final communityElement = findElementOrNull(element, "media:community");
    final embedElement = findElementOrNull(element, "media:embed");
    final statusElement = findElementOrNull(element, "media:status");
    final licenseElement = findElementOrNull(element, "media:license");
    final peerLinkElement = findElementOrNull(element, "media:peerLink");
    final rightsElement = findElementOrNull(element, "media:rights");

    return new Media(
      group: groupElement != null ? new Group.parse(groupElement) : null,
      contents: element.findElements("media:content").map((e) {
        return new Content.parse(e);
      }).toList(),
      credits: element.findElements("media:credit").map((e) {
        return new Credit.parse(e);
      }).toList(),
      category:
          categoryElement != null ? new Category.parse(categoryElement) : null,
      rating: ratingElement != null ? new Rating.parse(ratingElement) : null,
      title: titleElement != null ? new Title.parse(titleElement) : null,
      description: descriptionElement != null
          ? new Description.parse(descriptionElement)
          : null,
      keywords: findElementOrNull(element, "media:keywords")?.text,
      thumbnails: element.findElements("media:thumbnail").map((e) {
        return new Thumbnail.parse(e);
      }).toList(),
      hash: hashElement != null ? new Hash.parse(hashElement) : null,
      player: playerElement != null ? new Player.parse(playerElement) : null,
      copyright: copyrightElement != null
          ? new Copyright.parse(copyrightElement)
          : null,
      text: textElement != null ? new Text.parse(textElement) : null,
      restriction: restrictionElement != null
          ? new Restriction.parse(restrictionElement)
          : null,
      community: communityElement != null
          ? new Community.parse(communityElement)
          : null,
      comments: findElementOrNull(element, "media:comments")
              ?.findElements("media:comment")
              .map((e) {
            return e.text;
          }).toList() ??
          [],
      embed: embedElement != null ? new Embed.parse(embedElement) : null,
      responses: findElementOrNull(element, "media:responses")
              ?.findElements("media:response")
              .map((e) {
            return e.text;
          }).toList() ??
          [],
      backLinks: findElementOrNull(element, "media:backLinks")
              ?.findElements("media:backLink")
              .map((e) {
            return e.text;
          }).toList() ??
          [],
      status: statusElement != null ? new Status.parse(statusElement) : null,
      prices: element.findElements("media:price").map((e) {
        return new Price.parse(e);
      }).toList(),
      license:
          licenseElement != null ? new License.parse(licenseElement) : null,
      peerLink:
          peerLinkElement != null ? new PeerLink.parse(peerLinkElement) : null,
      rights: rightsElement != null ? new Rights.parse(rightsElement) : null,
      scenes: findElementOrNull(element, "media:scenes")
              ?.findElements("media:scene")
              .map((e) {
            return new Scene.parse(e);
          }).toList() ??
          [],
    );
  }
}
