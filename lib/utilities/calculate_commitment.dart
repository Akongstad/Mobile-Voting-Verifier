import 'dart:math';
import 'dart:typed_data';
import 'package:mobile_voting_verifier/repositories/eliptic_curve_repository.dart';
import 'package:mobile_voting_verifier/repositories/hashing_api.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';

Future<(String, ChallengeRequest)> calculateChallengeCommitment(
    ElipticCurveRepository ecRepository, BigInt e, BigInt r) async {
  final primeOrder = ecRepository.curve.n;
  // TODO Move somewhere?
  //final e = (ecRepository.generator.generateKeyPair().privateKey as ECPrivateKey).d!;
  //final r = (ecRepository.generator.generateKeyPair().privateKey as ECPrivateKey).d!;
  final k = ecRepository.k;
  final G = ecRepository.pointToBigInt(ecRepository.curve.G);


  final c = G.modPow(r, primeOrder) * k.modPow(e, primeOrder) % primeOrder;
  final hashedToBigintZq = await  HashingAPI.nonUniformHashIntoZq(await HashingAPI.encodeBigInt(c), ecRepository.curve);
  final hashedToBigintZqString = hashedToBigintZq.toRadixString(16);
  return (hashedToBigintZqString, ChallengeRequest(
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
