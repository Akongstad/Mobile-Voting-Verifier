import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';

Future<String> calculateChallengeCommitment(){
  return throw UnimplementedError();
}

Future<SecondDeviceLoginResponse> login(String voterId, String nonce, String password) async {
  //Calculate challenge commitment
  var challengeCommitment = calculateChallengeCommitment();

  var loginRequest = SecondDeviceLogin(challengeCommitment: await challengeCommitment,
      nonce: nonce, password: password, voterId: voterId);
  var httpResponse = http.post(
    Uri.parse('rest/login'), //TODO change to actual URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: loginRequest.toJson(),
  );
  return await httpResponse.then((value) => SecondDeviceLoginResponse.fromJson(value.body));
}

