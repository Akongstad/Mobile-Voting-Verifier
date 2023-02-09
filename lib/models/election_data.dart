// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

class ElectionData {
  final List<Language> languages;
  final I18n<String> title;

  ElectionData({
    required this.languages,
    required this.title,
  });

  /* ElectionData.fromJson(Map<String, dynamic> json, this.languages, this.title);

  Map<String, dynamic> toJson() => {}; */
}
