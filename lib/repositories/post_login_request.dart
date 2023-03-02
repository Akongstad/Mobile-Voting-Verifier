import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';

Future<String> calculateChallengeCommitment() async {
  return throw UnimplementedError();
}

Future<SecondDeviceLoginResponse> login(http.Client client, String voterId,
    String nonce, String password, String challengeCommitment) async {
  //Generate login request
  var loginRequest = SecondDeviceLogin(
      challengeCommitment: challengeCommitment,
      nonce: nonce,
      password: password,
      voterId: voterId);
  //Perform http request
  final response = await client.post(
    Uri.parse('/rest/login'), //TODO change to actual URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: loginRequest.toJson(),
  );

  if (response.statusCode == 200 &&
      jsonDecode(response.body)["status"] == "OK") {
    //Login succeeded
    return SecondDeviceLoginResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 200) {
    //Login Failed
    return throw ArgumentError("Invalid TOTP Password", "FailedLoginEvent");
  } else {
    return throw ArgumentError(
        "Failed to connect to end-point due to status code: ${response.statusCode}",
        "HTTPConnectionFailedEvent");
  }
}
