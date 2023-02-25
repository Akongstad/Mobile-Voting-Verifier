import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';

Future<String> calculateChallengeCommitment() async{
  return throw UnimplementedError();
}
Future<Map<String, dynamic>> parseResponseData(String responseBody) async =>
    jsonDecode(responseBody).cast<Map<String, dynamic>>();



Future<SecondDeviceLoginResponse> login(String voterId, String nonce, String password) async {
  //Calculate challenge commitment
  var challengeCommitment = calculateChallengeCommitment();
  //Generate login request
  var loginRequest = SecondDeviceLogin(challengeCommitment: await challengeCommitment,
      nonce: nonce, password: password, voterId: voterId);
  //Perform http request
  var httpResponse = http.post(
    Uri.parse('rest/login'), //TODO change to actual URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: loginRequest.toJson(),
  );
  return await httpResponse.then((value) async {
    var responseData = await compute(parseResponseData, value.body);
    if (responseData["status"] != "OK")
    {
      //Login succeeded
      return SecondDeviceLoginResponse.fromJson(responseData["value"]);
    }
    //Login Failed
    return throw ArgumentError("Invalid TOTP Password", "FailedLoginEvent");
  });
}

