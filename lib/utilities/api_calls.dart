import 'package:http/io_client.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/models/election_data.dart';
import 'package:mobile_voting_verifier/models/second_device_final_msg.dart';
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';
import 'package:mobile_voting_verifier/repositories/fetch_election_data.dart';
import 'package:mobile_voting_verifier/repositories/post_challenge_request.dart';
import 'package:mobile_voting_verifier/repositories/post_login_request.dart';

Future<ElectionData> electionDataRequest() async {
  var client = IOClient();
  ElectionData response = await fetchElectionData(client);
  client.close();

  return response;
}

Future<SecondDeviceLoginResponse> loginRequest(String voterId, String nonce,
    String password, String challengeCommitment) async {
  var secondDeviceLogin = SecondDeviceLogin(
      challengeCommitment: challengeCommitment,
      nonce: nonce,
      password: password,
      voterId: voterId);

  var client = IOClient();
  SecondDeviceLoginResponse response = await login(client, secondDeviceLogin);
  client.close();

  return response;
}

Future<SecondDeviceFinalMsg> challengeRequest(
    ChallengeRequest challengeRequest, String authToken) async {
  var client = IOClient();
  SecondDeviceFinalMsg response =
      await createChallenge(client, challengeRequest, authToken);
  client.close();

  return response;
}
