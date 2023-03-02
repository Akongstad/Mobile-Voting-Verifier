import 'package:mobile_voting_verifier/models/core_3_ballot.dart';

class VerifiableSecondDeviceParameters {
  final String publicKey;
  final String verificationKey;
  final List<Core3Ballot> ballots;

  VerifiableSecondDeviceParameters({
    required this.ballots,
    required this.publicKey,
    required this.verificationKey,
  });

  VerifiableSecondDeviceParameters.fromJson(Map<String, dynamic> json)
      : publicKey = json["publicKey"],
        verificationKey = json["verificationKey"],
        ballots = (json["ballots"] as List)
            .map((e) => Core3Ballot.fromJson(e)).toList();
}
