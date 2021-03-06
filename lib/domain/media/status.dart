import 'package:xml/xml.dart';

class Status {
  final String? state;
  final String? reason;

  Status({
    this.state,
    this.reason,
  });

  factory Status.parse(XmlElement element) {
    return new Status(
      state: element.getAttribute("state"),
      reason: element.getAttribute("reason"),
    );
  }
}
