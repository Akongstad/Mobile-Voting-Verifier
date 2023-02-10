import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/election_data.dart';

/* ElectionData parseElectionData(Map<String, dynamic> json) {
  String default_ = json['title']['default'] as String;

  return ElectionData(
      languages: [Language.en, Language.de],
      title: I18n(default_: "My Election Title", value: {}));
} */

Future<ElectionData> fetchElectionData() async {
  final response = await http
      .get(Uri.parse('/rest/electionData')); //TODO: placeholder end-point

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return electionDataFromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load election data');
  }
}
