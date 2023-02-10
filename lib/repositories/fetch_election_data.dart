import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/election_data.dart';

Future<ElectionData> fetchElectionData() async {
  final response = await http
      .get(Uri.parse('/rest/electionData')); //TODO: placeholder end-point

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ElectionData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load election data');
  }
}
