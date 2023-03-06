import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/utilities/calculate_commitment.dart';

void main() {
  group("test calculateCommitment()", () {
    test('check keyDerivationFunction from example', () async {
      var initialSeed = "kdk";
      var returnLength = 65;
      var label = "label";
      var context = "context";

      var actual =
          keyDerivationFunction(returnLength, initialSeed, label, context);
      var expected =
          "32 88 92 2A 96 65 33 C7 93 ED 53 20 45 FF FC 3C E6 BA 77 F2 7E 8F 60 C9 A3 D8 22 21 D8 6F 51 DD A0 07 36 DB A3 F8 AE 1D 94 B1 75 62 E8 38 D5 7F B8 54 00 D1 47 C6 E9 58 5E D4 D8 59 E4 61 20 B2 75"
              .toLowerCase()
              .replaceAll(' ', '');

      expect(actual.length, expected.length);
      expect(actual, expected);
    });
  });
}
