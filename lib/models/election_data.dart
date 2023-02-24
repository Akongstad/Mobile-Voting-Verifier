//import 'package:mobile_voting_verifier/models/enums/language.dart';
//import 'package:mobile_voting_verifier/models/i_18_n.dart';

class ElectionData {
  //final List<Language> languages; //TODO: Use Languages and I18n
  final String title; //I18n<String> title;

  ElectionData({
    //required this.languages,
    required this.title,
  });

  factory ElectionData.fromJson(Map<String, dynamic> json) {
    return ElectionData(
      title: json['title']['default'],
    );
  }
}
