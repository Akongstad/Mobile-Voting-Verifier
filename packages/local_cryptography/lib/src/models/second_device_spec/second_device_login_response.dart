
import 'package:local_cryptography/src/models/models.dart';

/// Model of the POLYAS response on succesful login.
/// - [allowInvalid]
/// - [ballotVoterId]
/// - [contentAbove]
/// - [electionId]
/// - [initialMessageJSON]
/// - [languages]
/// - [logo]
/// - [messages]
/// - [publicLabel]
/// - [title]
/// - [token]
///
class SecondDeviceLoginResponse {
  final bool allowInvalid;
  final String ballotVoterId;
  final Content? contentAbove;
  final String electionId;
  final String initialMessageJSON;
  final List<Language> languages;
  final I18n<ImageRef>? logo;
  final Map<String, I18n> messages;
  final String publicLabel;
  final I18n<String> title;
  final String token;

  SecondDeviceLoginResponse({
    required this.allowInvalid,
    required this.ballotVoterId,
    this.contentAbove,
    required this.electionId,
    required this.initialMessageJSON,
    required this.languages,
    this.logo,
    required this.messages,
    required this.publicLabel,
    required this.title,
    required this.token,
  });

  SecondDeviceLoginResponse.fromJson(Map<String, dynamic> jsonData)
      : token = jsonData['value']['token'],
        ballotVoterId = jsonData['value']['ballotVoterId'],
        electionId = jsonData['value']['electionId'],
        languages = (jsonData['value']['languages'] as List)
            .map((e) => Language.fromJson(e))
            .toList(),
        title = I18n.fromJsonString(jsonData['value']['title']),
        contentAbove = jsonData['value']['contentAbove'] != null
            ? Content.fromJson(jsonData['value']['contentAbove'])
            : null,
        //TODO handle polymorphism
        publicLabel = jsonData['value']['publicLabel'],
        messages = (jsonData['value']['messages'] as Map)
            .map((key, value) => MapEntry(key, I18n.fromJsonString(value))),
        allowInvalid = jsonData['value']['allowInvalid'] as bool,
        initialMessageJSON = jsonData['value']['initialMessage'],
        logo = null;

  //logo = I18n.fromJsonMap(jsonData['logo'], ImageRef.fromJson);

  Map<String, dynamic> toJson() => {
        'allowInvalid ': allowInvalid,
        'ballotVoterId': ballotVoterId,
        'contentAbove': contentAbove ?? "",
        'electionId': electionId,
        'initialMessage': initialMessageJSON,
        'languages': languages,
        'logo': logo ?? "",
        'messages': messages,
        'publicLabel': publicLabel,
        'title': title,
        'token': token
      };
}
