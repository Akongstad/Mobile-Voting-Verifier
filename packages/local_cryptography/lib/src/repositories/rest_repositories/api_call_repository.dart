import 'package:http/io_client.dart';
import 'package:local_cryptography/src/models/models.dart';
import 'package:local_cryptography/src/repositories/repositories.dart';


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
