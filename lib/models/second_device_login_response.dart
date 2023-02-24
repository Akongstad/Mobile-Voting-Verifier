import 'package:mobile_voting_verifier/models/content.dart';
import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';
import 'package:mobile_voting_verifier/models/image_ref.dart';

class SecondDeviceLoginResponse {
  final bool allowInvalid;
  final String ballotVoterId;
  final Content? contentAbove;
  final String electionId;
  final String initialMessage;
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
    required this.initialMessage,
    required this.languages,
    this.logo,
    required this.messages,
    required this.publicLabel,
    required this.title,
    required this.token,
  });
  //TODO Add fromJson factory methods to subtypes.
  SecondDeviceLoginResponse.fromJson(Map<String, dynamic> json)
      : allowInvalid = json['allowInvalid'],
        ballotVoterId = json['ballotVoterId'],
        contentAbove = json['contentAbove'],
        electionId = json['electionId'],
        initialMessage = json['initialMessage'],
        languages = json['languages'],
        logo = json['logo'],
        messages = json['messages'],
        publicLabel = json['publicLabel'],
        title = json['title'],
        token = json['token'];


  Map<String, dynamic> toJson() => {
    'allowInvalid ': allowInvalid,
    'ballotVoterId': ballotVoterId,
    'contentAbove' : contentAbove ?? "",
    'electionId' : electionId,
    'initialMessage' : initialMessage,
    'languages' : languages,
    'logo' : logo ?? "",
    'messages' :  messages,
    'publicLabel' : publicLabel,
    'title' : title,
    'token' : token
  };

}
