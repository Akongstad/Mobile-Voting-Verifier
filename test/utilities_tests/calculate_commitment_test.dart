import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:elliptic/elliptic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/utilities/calculate_commitment.dart';
import "package:pointycastle/export.dart";


void main() {
  group("decodeECPoint tests", () {
    final expected = BigInt.parse(
        "723700557733226221397318656304299424082937404160253525246609900049430216698");
    final point = (BigInt.parse(
        "7fffffffffffffffffffffffffffffffffffffffffffffffffffffff7ffffe21",
        radix: 16),
    BigInt.parse(
        "2af4d53f09f4d4ede3caf3f0e06ccfc0f55289d83fed859ca504d6033bec629b",
        radix: 16));
    test('check numbersFromSeedAsync from example', () async {
      final actual = await decodeECPoint(point.$1, point.$2);
      expect(actual, expected);
    });
  });
  group(
      "Test the pointy castle implementation for interesting useful functionality", () {
    var secp256k1 = ECCurve_secp256k1();
    final G = (
    BigInt.parse(
        "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798",
        radix: 16),
    BigInt.parse(
        "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8",
        radix: 16));
    var q = BigInt.parse(
        "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141",
        radix: 16);
    var p = BigInt.parse(
        "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
        radix: 16);

    test('Test key generation', () async {
      // Creating a seed for secp256k1
      final seed = utf8.encode("xyz");

      //INIT SECURE RANDOM "FORTUNA".
      //Once seeded will produce an indefinite quantity of pseudo-random data.
      final sGen = Random.secure();
      final randSeed = Uint8List.fromList(
          List.generate(32, (n) => sGen.nextInt(255)));
      final secureRandom = FortunaRandom()
        ..seed(KeyParameter(randSeed));

      // Initialize secp256k1 with seed defined above
      var domainParams = ECDomainParametersImpl(
          secp256k1.domainName, secp256k1.curve, secp256k1.G, secp256k1.n,
          secp256k1.h, seed);

      // Initialize key generator from secp256k1 and FORTUNA random
      var keyParams = ECKeyGeneratorParameters(domainParams);
      var paramsWithRandom = ParametersWithRandom<ECKeyGeneratorParameters>(
          keyParams, secureRandom);

      // Initialize ElipticCurveKeyGenerator from paramaters above
      var generator = ECKeyGenerator();
      generator.init(paramsWithRandom);
      var fsdfdasf = getSecp256k1();
      var keyPair = generator.generateKeyPair();
      var privateKey = keyPair.privateKey;
      var publicKey = keyPair.publicKey;
      expect(true, true);
    });

    test('Test parameters against specification', () async {
      /*
      * Conclusion:
      * G = _G
      * Finite field p = _q
      * prime order q = _n
      */
      var qImplementation = BigInt.parse(
          "115792089237316195423570985008687907853269984665640564039457584007908834671663");
      var nImplementation = BigInt.parse(
          "115792089237316195423570985008687907852837564279074904382605163141518161494337");
      var GImplemenation = secp256k1.G;
      var GPoint = secp256k1.curve.createPoint(G.$1, G.$2);
      expect(GPoint.x, GImplemenation.x);
      expect(GPoint.y, GImplemenation.y);
      expect(p, qImplementation);
      expect(q, nImplementation);
    });
    test('Test point.getEncoded', () async {
      final point = secp256k1.curve.createPoint(BigInt.parse(
          "75788b8a22a04baad44c66ec80e86928597979bf1b287760ad4e3153293d613b",
          radix: 16), BigInt.parse(
          "664663757d16eff0b993ac12a1ba16ee4784ac08206b12be50f4d954d9d74c88",
          radix: 16));
      const expected = "0275788B8A22A04BAAD44C66EC80E86928597979BF1B287760AD4E3153293D613B";
      var pointBytes = point.getEncoded(true);
      // Pad left if byte size less than 2. Per default 0x2
      var pointAsHex = pointBytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join().toUpperCase();
      expect(pointAsHex, expected);
    });
  });
}
