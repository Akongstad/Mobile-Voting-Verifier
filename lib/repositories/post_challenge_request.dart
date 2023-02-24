import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/models/response_bean.dart';

Future<OK> createChallenge(http.Client client,
    ChallengeRequest challengeRequest, String authToken) async {
  final response = await client.post(
    Uri.parse('/rest/challenge'), //TODO: placeholder endpoint
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': authToken,
    },
    body: challengeRequest.toJson(),
  );

  if (response.statusCode == 200) {
    return OK.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to post challengeRequest');
  }
}