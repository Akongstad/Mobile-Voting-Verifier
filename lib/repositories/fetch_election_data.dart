import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/election_data.dart';

Future<ElectionData> fetchElectionData(http.Client client) async {
  final response =
      await client.get(Uri.parse('/rest/electionData')); //TODO: placeholder URI

  if (response.statusCode == 200) {
    return ElectionData.fromJson(jsonDecode(response.body));
  } else {
    return throw Exception('Failed to load election data');
  }
}
