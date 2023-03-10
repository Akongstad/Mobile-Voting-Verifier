import 'dart:math';
import 'dart:typed_data';
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
  final k = ecRepository.k;
  final G = ecRepository.pointToBigInt(ecRepository.curve.G);

  //Compute commitment c: c = G^r * K^e
  final c = G.modPow(r, primeOrder) * k.modPow(e, primeOrder) % primeOrder;

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

Future<BigInt> sampleFromPrimeOrder() async {
  var primeOrder = BigInt.parse(
      'fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141',
      radix: 16);

  while (true) {
    var randSample = _randomBigIntFromPrimerOrder(primeOrder);
    if (randSample < primeOrder) {
      return randSample;
    }
  }
}

BigInt _randomBigIntFromPrimerOrder(BigInt primeOrder) {
  const size = 32;
  final random = Random.secure();
  final builder = BytesBuilder();
  for (var i = 0; i < size; ++i) {
    builder.addByte(random.nextInt(256));
  }

  final bytes = builder.toBytes();

  String binString = bytes.map((e) => e.toRadixString(2).padLeft(8, "0"))
      .join();

  return BigInt.parse(binString, radix: 2);
}
