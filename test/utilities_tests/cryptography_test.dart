import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/utilities/cryptography.dart';

void main() {
  group("test keyDerivationFunction()", () {
    test(
        'check keyDerivationFunction with specific input matches example output',
        () async {
      var initialSeed = utf8.encode("kdk");
      var returnLength = 65;
      var label = utf8.encode("label");
      var context = utf8.encode("context");

      var hexExpected = [
        '32',
        '88',
        '92',
        '2A',
        '96',
        '65',
        '33',
        'C7',
        '93',
        'ED',
        '53',
        '20',
        '45',
        'FF',
        'FC',
        '3C',
        'E6',
        'BA',
        '77',
        'F2',
        '7E',
        '8F',
        '60',
        'C9',
        'A3',
        'D8',
        '22',
        '21',
        'D8',
        '6F',
        '51',
        'DD',
        'A0',
        '07',
        '36',
        'DB',
        'A3',
        'F8',
        'AE',
        '1D',
        '94',
        'B1',
        '75',
        '62',
        'E8',
        '38',
        'D5',
        '7F',
        'B8',
        '54',
        '00',
        'D1',
        '47',
        'C6',
        'E9',
        '58',
        '5E',
        'D4',
        'D8',
        '59',
        'E4',
        '61',
        '20',
        'B2',
        '75'
      ];

      List<int> expected = [];

      for (var element in hexExpected) {
        expected.add(int.parse(element, radix: 16));
      }

      var actual =
          keyDerivationFunction(returnLength, initialSeed, label, context);

      expect(actual.length, expected.length);
      expect(actual, expected);
    });
  });

  group("numbersFromSeedAsync tests", () {
    var l = 520;
    var seed = utf8.encode("xyz");
    BigInt a1 = BigInt.parse(
        "1732501504205220402900929820446308723705652945081825598593993913145942097001127020633138020218038968109094917857329663184563374015879596834703721749398989648");
    BigInt a2 = BigInt.parse(
        "2207401303665503434031531355511922974889692817601183500259263742625914061046146142929376778072827450461936300533206904979740474482058840003720379960491023511");
    BigInt a3 = BigInt.parse(
        "1883889587903519477357838514223953979954201344665681798367023196328721975720052153913582122151913785273222921786889836987731296728825119604809609410157987402");
    BigInt a4 = BigInt.parse(
        "1423259849467217711185874799515607842842602785767879766623736284680209832704638390900412597196948750015976271793930713744890547611655064835165883323889981463");
    test('check numbersFromSeedAsync from example', () async {
      var actual = await numbersFromSeedAsync(l, seed).toList();
      var first = actual.first;
      var second = actual[1];
      var third = actual[2];
      var fourth = actual[3];

      expect(first, a1);
      expect(second, a2);
      expect(third, a3);
      expect(fourth, a4);
    });
    test('check numbersFromSeedFuturesAsync from example', () async {
      var actual = await numbersFromSeedFuturesAsync(l, seed).toList();
      var first = await actual.first;
      var second = await actual[1];
      var third = await actual[2];
      var fourth = await actual[3];

      expect(first, a1);
      expect(second, a2);
      expect(third, a3);
      expect(fourth, a4);
    });
  });
}
