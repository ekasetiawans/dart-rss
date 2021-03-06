import 'package:xml/xml.dart';

class RssItunesImage {
  final String? href;

  RssItunesImage({this.href});

  factory RssItunesImage.parse(XmlElement element) {
    return RssItunesImage(
      href: element.getAttribute("href")?.trim(),
    );
  }
}
