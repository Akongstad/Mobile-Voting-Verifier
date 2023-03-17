import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/repositories/api/ec_encoding_api.dart';
import 'package:mobile_voting_verifier/repositories/eliptic_curve_repository.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

void main() {
  final params = ECCurve_secp256k1();
  final expectedDecodedMessage = BigInt.parse(
      "723700557733226221397318656304299424082937404160253525246609900049430216698");
  final expectedEncodedpoint = params.curve.createPoint(
      BigInt.parse(
          "7fffffffffffffffffffffffffffffffffffffffffffffffffffffff7ffffe21",
          radix: 16),
      BigInt.parse(
          "2af4d53f09f4d4ede3caf3f0e06ccfc0f55289d83fed859ca504d6033bec629b",
          radix: 16));

  group("decodePoint tests", () {
    test('decodePoint returns expected message given by example input',
        () async {
      final actual = await ECEncodingAPI.decodeFromPoint(
          expectedEncodedpoint.x!.toBigInteger()!,
          expectedEncodedpoint.y!.toBigInteger()!);
      expect(actual, expectedDecodedMessage);
    });
  });

  group("encodePoint tests", () {
    test('encodePoint returns expected point given example input message',
        () async {
      final primeP = IEllipticCurveRepository.p;
      final actual = await ECEncodingAPI.encodeToPoint(
          expectedDecodedMessage, primeP, params);
      expect(actual, expectedEncodedpoint);
    });
  });
}
