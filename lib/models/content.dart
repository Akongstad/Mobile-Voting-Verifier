import 'package:mobile_voting_verifier/models/document.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

abstract class Content<T> {
  //TODO: Fix abstraction
  Content();
  Content.fromJson(Map<String, dynamic> json);
}

class RichText extends Content {
  final I18n<Document> value;
  final String contentType = "RICH_TEXT";

  RichText({required this.value});
  
  @override
  RichText.fromJson(Map<String, dynamic> json) :
      value = I18n.fromJsonMap(json["value"],
              (json) => json['value']['default']);
}

class Text extends Content {
  final I18n<String> value;
  final String contentType = "TEXT";

  Text({required this.value});

  @override
  Text.fromJson(Map<String, dynamic> json) :
        value = I18n.fromJsonString(json);
}
