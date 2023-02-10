import 'dart:io';

import 'package:mobile_voting_verifier/models/document.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

abstract class Content<T> {
  //TODO: Fix abstraction
}

class RichText extends Content {
  final I18n<Document> value;
  final contentType = "RICH_TEXT";

  RichText({required this.value});
}

class Text extends Content {
  final I18n<String> value;
  final contentType = "TEXT";

  Text({required this.value});
}
