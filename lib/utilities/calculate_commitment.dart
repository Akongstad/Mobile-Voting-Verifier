import 'package:mobile_voting_verifier/repositories/api/ec_encoding_api.dart';
import 'package:mobile_voting_verifier/repositories/eliptic_curve_repository.dart';
import 'package:mobile_voting_verifier/repositories/api/hashing_api.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';

/* Calculates a Pedersen commitment and returns a tuple of the commitment as hex
 *
 * and a `ChallengeRequest` object with randomly sampled `e` and `r` values.
 */
Future<(String, ChallengeRequest)> calculateChallengeCommitment(
    EllipticCurveRepository ecRepository, BigInt e, BigInt r) async {
  final p = IEllipticCurveRepository.p;
  final q = IEllipticCurveRepository.q;
  final k = IEllipticCurveRepository.compressedK;
  final G = IEllipticCurveRepository.compressedG;
  // Sample random values for e and r
  /*final rng = ecRepository.random;
  final e = rng.nextBigInteger(q.bitLength) % q;
  final r = rng.nextBigInteger(q.bitLength) % q;*/

  final c = await _pedCommit(G, k, e, r, p);
  final bytesToHexString = await _cToPointToHex(c, ecRepository);
  return (bytesToHexString, ChallengeRequest(
      challenge: e, challengeRandomCoin: r));
}

/* Computes a Pedersen commitment `c = G^r * K^e` modulo `p`.
 *
 * `G` is a generator of the elliptic curve group `Zp`.
 *
 * `k` is the commitment key, a point on the elliptic curve.
 *
 * `e` and `r` are BigIntegers randomly sampled from the set `Zq`.
 *
 * `p` is the order of the elliptic curve group `Zp`.
 */
Future<BigInt> _pedCommit(BigInt G, BigInt k, BigInt e, BigInt r,
    BigInt p) async =>
    (G.modPow(r, p) * k.modPow(e, p)) % p;

Future<String> _cToPointToHex(BigInt c,
    EllipticCurveRepository ecRepository) async {
  //Encode c to point on the curve.
  final encodeToZqPoint = await ECEncodingAPI.encodeToPoint(
      c, IEllipticCurveRepository.p, ecRepository.curve);

  //Encode point(c) to bytes
  final pointAsBytes = await DefaultHashingAPI().encodeECPoint(encodeToZqPoint);

  //Decode bytes to hex
  return await DefaultHashingAPI.bytesToHex(pointAsBytes);
}

