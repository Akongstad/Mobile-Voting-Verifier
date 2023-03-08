import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';
import 'package:mobile_voting_verifier/models/challenge_request.dart';

Future<(String, ChallengeRequest)> calculateChallengeCommitment(BigInt k, (BigInt x, BigInt y) G) async {
  return throw UnimplementedError();
}

Future<BigInt> sampleFromPrimeOrder() async {
  var primeOrder = BigInt.parse('fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141', radix: 16);

  while (true) {
    var randSample = _randomBigIntFromPrimerOrder(primeOrder);
    if (randSample < primeOrder){
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

  String binString = bytes.map((e) => e.toRadixString(2).padLeft(8, "0")).join();
  
  return BigInt.parse(binString, radix: 2);
}

// floor is default for bigint division
Future<BigInt> decodeECPoint(BigInt x, BigInt y, {int k = 80}) async =>
    (x - BigInt.one) ~/ BigInt.from(k);

