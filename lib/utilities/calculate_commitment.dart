import 'package:mobile_voting_verifier/repositories/eliptic_curve_repository.dart';
import 'package:mobile_voting_verifier/repositories/api/hashing_api.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:pointycastle/ecc/api.dart';

/* Calculates a Pedersen commitment and returns a tuple of the commitment as hex
 *
 * and a `ChallengeRequest` object with randomly sampled `e` and `r` values.
 */
Future<(String, ChallengeRequest)> calculateChallengeCommitment(
    EllipticCurveRepository ecRepository, BigInt e, BigInt r) async {
  final p = IEllipticCurveRepository.p;
  final k = IEllipticCurveRepository.hexK;
  final G = IEllipticCurveRepository.hexG;

  // Sample random values for e and r
  /*final rng = ecRepository.random;
  final e = rng.nextBigInteger(q.bitLength) % q;
  final r = rng.nextBigInteger(q.bitLength) % q;*/

  final gPoint =  await ecRepository.pointRepository.fromBigInt(G);
  final kPoint = await ecRepository.pointRepository.fromBigInt(k);

  final c = await _pedCommit(gPoint, kPoint, e, r, p);
  return (c, ChallengeRequest(
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
Future<String> _pedCommit(ECPoint G, ECPoint k, BigInt e, BigInt r,
    BigInt p) async {
  final intermed1 = G * e;
  final intermed2 = k * r;
  final challengeInt = intermed1! + intermed2!;
  final challengeCommit = await DefaultHashingAPI.pointToHex(challengeInt!);
  return challengeCommit;
}

