import 'package:mobile_voting_verifier/repositories/api/ec_encoding_api.dart';
import 'package:mobile_voting_verifier/repositories/eliptic_curve_repository.dart';
import 'package:mobile_voting_verifier/repositories/api/hashing_api.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';

/*
 * Input: repository for operations on EC, Randomly sampled e, r from Zq
 * Output: (commitment HexString, ChallengeRequest(e, r))
 */
Future<(String, ChallengeRequest)> calculateChallengeCommitment(
    ElipticCurveRepository ecRepository, BigInt e, BigInt r) async {
  final primeOrder = ecRepository.curve.n;

  // Define Independent generators.
  final k = ecRepository.compressedK;
  final G = ecRepository.compressedG;
  
  //Compute commitment c: c = G^r * K^e
  final c = (G.modPow(r, primeOrder) * k.modPow(e, primeOrder)) % primeOrder;

  //Encode c to point on the curve.
  final encodeToZqPoint = await ECEncodingAPI.encodeToPoint(
      c, ECEncodingAPI.specP, ecRepository.curve);

  //Encode point(c) to bytes
  final pointAsBytes = await HashingAPI.encodeECPoint(encodeToZqPoint);

  //Decode bytes to hex
  final bytesToHexString = await HashingAPI.bytesToHex(pointAsBytes);

  // Return(hex, (e,r))
  return (bytesToHexString, ChallengeRequest(
      challenge: e, challengeRandomCoin: r));
}
