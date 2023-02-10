import 'package:mobile_voting_verifier/models/core_3_ballot.dart';

class VerifiableSecondDeviceParameters {
  final List<Core3Ballot> ballots;
  final String publicKey;
  final String verificationKey;

  VerifiableSecondDeviceParameters({
    required this.ballots,
    required this.publicKey,
    required this.verificationKey,
  });
}
