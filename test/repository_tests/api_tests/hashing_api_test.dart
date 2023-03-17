import 'package:flutter_test/flutter_test.dart';
import 'package:hex/hex.dart';
import 'package:mobile_voting_verifier/repositories/api/hashing_api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

void main() {
  group("Hashing API encodeECPoint tests", () {
    final secp256k1 = ECCurve_secp256k1();
    test('Test encodeECPoint for point in specifications', () async {
      final point = secp256k1.curve.createPoint(
          BigInt.parse(
              "75788b8a22a04baad44c66ec80e86928597979bf1b287760ad4e3153293d613b",
              radix: 16),
          BigInt.parse(
              "664663757d16eff0b993ac12a1ba16ee4784ac08206b12be50f4d954d9d74c88",
              radix: 16));
      final expected =
          "0275788B8A22A04BAAD44C66EC80E86928597979BF1B287760AD4E3153293D613B"
              .toLowerCase();

      var pointBytes = await DefaultHashingAPI().encodeECPoint(point);
      var pointAsHex = HEX.encode(pointBytes);

      expect(pointAsHex, expected);
    });

    test('Test encodeECPoint in secp256k1 for point G', () async {
      final point = secp256k1.G;
      final expected =
          "0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798"
              .toLowerCase();

      var pointBytes = await DefaultHashingAPI().encodeECPoint(point);
      var pointAsHex = HEX.encode(pointBytes);

      expect(pointAsHex, expected);
    });
  });
}
