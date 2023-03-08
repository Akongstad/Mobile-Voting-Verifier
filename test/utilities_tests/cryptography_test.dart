import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/utilities/cryptography.dart';

void main() {
  group("numbersFromSeedAsync tests", () {
    var l = 520;
    var seed = utf8.encode("xyz");
    BigInt a1 = BigInt.parse("1732501504205220402900929820446308723705652945081825598593993913145942097001127020633138020218038968109094917857329663184563374015879596834703721749398989648");
    BigInt a2 = BigInt.parse("2207401303665503434031531355511922974889692817601183500259263742625914061046146142929376778072827450461936300533206904979740474482058840003720379960491023511");
    BigInt a3 = BigInt.parse("1883889587903519477357838514223953979954201344665681798367023196328721975720052153913582122151913785273222921786889836987731296728825119604809609410157987402");
    BigInt a4 = BigInt.parse("1423259849467217711185874799515607842842602785767879766623736284680209832704638390900412597196948750015976271793930713744890547611655064835165883323889981463");

    BigInt a5 = BigInt.parse("300889668866034139069124727889607448675321904420316939286422373409404958717979350271745428651492739692008689990629401024794340355677791213941");
    test('check numbersFromSeedAsync from example', () async {
      var sw = Stopwatch();
      sw.start();
      var actual = await numbersFromSeedAsync2(l, seed).toList();
      var first =  actual.first;
      var second =  actual[1];
      var third =  actual[2];
      var fourth =  actual[3];
      var elapsed = sw.elapsed; //100.000 elements: 0:00:04.463883
      expect(first, a1);
      expect(second, a2);
      expect(third, a3);
      expect(fourth, a4);
    });
  });
}
