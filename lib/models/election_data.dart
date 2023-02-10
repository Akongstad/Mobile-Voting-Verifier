import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

class ElectionData {
  final List<Language> languages;
  final I18n<String> title;

  ElectionData({
    required this.languages,
    required this.title,
  });
}

ElectionData electionDataFromJson(Map<String, dynamic> json) {
  List<Language> langAsEnum = [];

  for (dynamic element in json['languages']) {
    langAsEnum.add(getLanguageFromString(element));
  }

  return ElectionData(
    languages: langAsEnum,
    title: json['title'],
  );
}

Language getLanguageFromString(dynamic languageAsDynamic) {
  for (Language element in Language.values) {
    String languageAsString = languageAsDynamic as String;
    if (element.toString() == languageAsString.toLowerCase()) {
      return element;
    }
  }
  throw Exception("Localization failed");
}
