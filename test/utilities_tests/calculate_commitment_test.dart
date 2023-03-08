import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/utilities/calculate_commitment.dart';

void main() {

  group("decodeECPoint tests", () {
    final expected  = BigInt.parse("723700557733226221397318656304299424082937404160253525246609900049430216698");
    final point = (BigInt.parse("7fffffffffffffffffffffffffffffffffffffffffffffffffffffff7ffffe21", radix: 16) ,
        BigInt.parse("2af4d53f09f4d4ede3caf3f0e06ccfc0f55289d83fed859ca504d6033bec629b", radix: 16));
    test('check numbersFromSeedAsync from example', () async {
      final actual = await decodeECPoint(point.$1, point.$2);
      expect(actual, expected);
    });
  });
}
