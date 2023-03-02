import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/models/election_data.dart';
import 'package:mobile_voting_verifier/models/second_device_final_msg.dart';
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';

Future<ElectionData> electionDataRequest() async {
  return throw UnimplementedError();
}

Future<SecondDeviceLoginResponse> loginRequest(
    SecondDeviceLogin secondDeviceLogin) async {
  return throw UnimplementedError();
}

Future<SecondDeviceFinalMsg> challengeRequest(
    ChallengeRequest challenge, String authToken) async {
  return throw UnimplementedError();
}
