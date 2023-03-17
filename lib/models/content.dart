import 'package:mobile_voting_verifier/models/document.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

sealed class Content<T> {
  //TODO: May need to be generic, but for now can only be Text or RichText, so it doesnt matter
  Content();
  factory Content.fromJson(Map<String, dynamic> json)
    => switch(json["contentType"]) {
      "RICH_TEXT" => RichText.fromJson(json) as Content<T>,
      "TEXT" => Text.fromJson(json) as Content<T>,
      _ => Text.fromJson(json) as Content<T>};

  // Accessor methods to be overridden
  String get contentType => throw ArgumentError("");
  I18n<T> get value => throw  ArgumentError("");
}

class RichText extends Content {
  @override
  final I18n<Document> value;
  @override
  final String contentType = "RICH_TEXT";

  RichText({required this.value});

  @override
  RichText.fromJson(Map<String, dynamic> json) :
      value = I18n.fromJsonMap(json["value"],
              (json) => json['value']['default']);
}

class Text extends Content {
  @override
  final I18n<String> value;
  @override
  final String contentType = "TEXT";

  Text({required this.value});

  @override
  Text.fromJson(Map<String, dynamic> json) :
        value = I18n.fromJsonString(json['value']);
}
