import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/repositories/api/ec_encoding_api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

void main() {

  group("decodePoint tests", () {
    final secp256k1 = ECCurve_secp256k1();
    test('Test point.getEncoded', () async {
      final point = secp256k1.curve.createPoint(BigInt.parse(
          "75788b8a22a04baad44c66ec80e86928597979bf1b287760ad4e3153293d613b",
          radix: 16), BigInt.parse(
          "664663757d16eff0b993ac12a1ba16ee4784ac08206b12be50f4d954d9d74c88",
          radix: 16));
      const expected = "0275788B8A22A04BAAD44C66EC80E86928597979BF1B287760AD4E3153293D613B";
      var pointBytes = point.getEncoded(true);
      // Pad left if byte size less than 2. Per default 0x2
      var pointAsHex = pointBytes.map((e) =>
          e.toRadixString(16).padLeft(2, '0')).join().toUpperCase();
      expect(pointAsHex, expected);
    });
  });
}