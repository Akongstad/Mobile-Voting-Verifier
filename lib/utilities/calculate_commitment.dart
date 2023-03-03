import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:elliptic/elliptic.dart';

Future<(String, ChallengeRequest)> calculateChallengeCommitment() async {
  var ecurve1 = getSecp256k1();
  var ecurve2 = getSecp256k1();

  var e = ecurve1.a;
  var r = ecurve2.a;
  


  return ("Test", ChallengeRequest(challenge: e, challengeRandomCoin: r));
  //return throw UnimplementedError();
}
