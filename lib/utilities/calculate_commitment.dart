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
  //return throw UnimplementedError(); // TODO: Await Tomasz Truderung
  final primeOrder = ecRepository.curve.n;

  // Define Independent generators.
  final k = ecRepository.compressedK;
  final G = ecRepository.compressedG;

  //Compute commitment c: c = (G^r % q) * (K^e % q) % q
  final c = await _pedCommit(G, k, e, r, primeOrder);

  //Encode c to point on the curve.
  //Encode point(c) to bytes
  //Decode bytes to hex
  final bytesToHexString = await _cToPointToHex(c, ecRepository);

  return (bytesToHexString, ChallengeRequest(
      challenge: e, challengeRandomCoin: r));
}

//Compute pedersen commitment c: c = G^r * K^e
Future<BigInt> _pedCommit(BigInt G, BigInt k, BigInt e, BigInt r,
    BigInt primeOrder) async =>
    (G.modPow(r, primeOrder) * k.modPow(e, primeOrder)) % primeOrder;

Future<String> _cToPointToHex(BigInt c, ElipticCurveRepository ecRepository) async {
  //Encode c to point on the curve.
  final encodeToZqPoint = await ECEncodingAPI.encodeToPoint(
      c, ECEncodingAPI.specP, ecRepository.curve);

  //Encode point(c) to bytes
  final pointAsBytes = await HashingAPI.encodeECPoint(encodeToZqPoint);

  //Decode bytes to hex
  return await HashingAPI.bytesToHex(pointAsBytes);
}

