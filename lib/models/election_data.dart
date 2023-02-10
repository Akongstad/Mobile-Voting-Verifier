import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

class ElectionData {
  final List<Language> languages;
  final I18n<String> title;

  ElectionData({
    required this.languages,
    required this.title,
  });

  factory ElectionData.fromJson(Map<String, dynamic> json) {
    return ElectionData(
      title: I18n<String>(
        default_: json['title']['default'],
        value: json['title']['value'],
      ),
      languages: json['languages'],
    );
  }

  List<Language> toEnumLanguages(List<String> languagesString) {
    List<Language> languages = [];

    for (var element in languagesString) {
      languages.add(Language.fromString(element));
    }

    return languages;
  }
}
