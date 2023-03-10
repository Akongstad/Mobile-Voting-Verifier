import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/models/algorithms/tonelli_shanks.dart';

void main() {
  group("solve tests", () {
    List<(int, int)> pairs = [
      (10, 13),
      (56, 101),
      (1030, 10009),
      (1032, 10009),
      (44402, 100049),
      (665820697, 1000000009),
      (881398088036, 1000000000039),
    ];
    List<(int, int)> sols = [
      (7, 6),
      (37, 64),
      (1632, 8377),
      (0, 0),
      (30468, 69581),
      (378633312, 621366697),
      (791399408049, 208600591990),
    ];

    test('test solve given sample inputs return expected outputs', () async {
      for (var i = 0; i < pairs.length; i++) {
        var actual = await TonelliShanks.tsSolve(
            BigInt.from(pairs[i].$1), BigInt.from(pairs[i].$2));
        expect(actual.root1.toInt(), sols[i].$1);
        expect(actual.root2.toInt(), sols[i].$2);
      }
    });
    test('test solve given BigInt input return expected output', () async {
      final expectedRoot1 = BigInt.parse("32102985369940620849741983987300038903725266634508");
      final expectedRoot2 = BigInt.parse("67897014630059379150258016012699961096274733366069");
      var actual = await TonelliShanks.tsSolve(BigInt.parse(
          "41660815127637347468140745042827704103445750172002", radix: 10),
          BigInt.parse("100000000000000000000000000000000000000000000000577",
              radix: 10));
      expect(actual.root1, expectedRoot1);
      expect(actual.root2, expectedRoot2);
    });
  });
}