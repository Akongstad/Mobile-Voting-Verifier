import 'package:mobile_voting_verifier/models/challenge_request.dart';

Future<(String, ChallengeRequest)> calculateChallengeCommitment() async {
  return throw UnimplementedError();
}

// floor is default for bigint division
Future<BigInt> decodeECPoint(BigInt x, BigInt y, {int k = 80}) async =>
    (x - BigInt.one) ~/ BigInt.from(k);
