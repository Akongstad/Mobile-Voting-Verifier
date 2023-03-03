import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/utilities/calculate_commitment.dart';

void main() {
  group("test calculateCommitment()", () {
    test('check ChallengeRequest', () async {
      var expected = ("Test", ChallengeRequest(challenge: BigInt.zero, challengeRandomCoin: BigInt.zero));
      var actual = await calculateChallengeCommitment();
      expect(actual.$1, expected.$1);
      expect(actual.$2.challenge, expected.$2.challenge);
      expect(actual.$2.challengeRandomCoin, expected.$2.challengeRandomCoin);
    });
  });
}
