import 'package:local_cryptography/src/models/models.dart';

class Content<T> {
  //TODO: May need to be generic, but for now can only be Text or RichText, so it doesnt matter
  Content();
  factory Content.fromJson(Map<String, dynamic> json){
    switch(json["contentType"]) {

      case "RICH_TEXT": return ContentRichText.fromJson(json) as Content<T>;
      case "TEXT": return ContentText.fromJson(json) as Content<T>;
      default: return ContentText.fromJson(json) as Content<T>;
    };
  }

  // Accessor methods to be overridden
  String get contentType => throw ArgumentError("");
  I18n<T> get value => throw  ArgumentError("");
}

class ContentRichText extends Content {
  @override
  final I18n<Document> value;
  @override
  final String contentType = "RICH_TEXT";

  ContentRichText({required this.value});

  @override
  ContentRichText.fromJson(Map<String, dynamic> json) :
      value = I18n.fromJsonMap(json["value"],
              (json) => json['value']['default']);
}

class ContentText extends Content {
  @override
  final I18n<String> value;
  @override
  final String contentType = "TEXT";

  ContentText({required this.value});

  @override
  ContentText.fromJson(Map<String, dynamic> json) :
        value = I18n.fromJsonString(json['value']);
}
