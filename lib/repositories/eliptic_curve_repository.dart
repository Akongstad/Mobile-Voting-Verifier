import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class ElipticCurveRepository {
  String? seed;
  final SecureRandom random;
  final ECDomainParameters curve;
  final ECKeyGenerator generator;
  final BigInt compressedK = BigInt.parse(
      "0373744f99d31509eb5f8caaabc0cc3fab70e571a5db4d762020723b9cd6ada260",
      radix: 16);
  final BigInt compressedG = BigInt.parse(
      "0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798",
      radix: 16);

  factory ElipticCurveRepository.fromSeed(String seed) {
    final secureRandom = _initSecureRandom();
    final curveInit = _initCurveSeeded(utf8.encode(seed));
    final generatorInit = _initKeyGenerator(curveInit, secureRandom);
    return ElipticCurveRepository(
        seed: seed,
        random: secureRandom,
        curve: curveInit,
        generator: generatorInit);
  }

  factory ElipticCurveRepository.noSeed() {
    final secureRandom = _initSecureRandom();
    final curveInit = ECCurve_secp256k1();
    final generatorInit = _initKeyGenerator(curveInit, secureRandom);
    return ElipticCurveRepository(
        random: secureRandom, curve: curveInit, generator: generatorInit);
  }

  ElipticCurveRepository(
      {this.seed,
      required this.random,
      required this.curve,
      required this.generator});

  static SecureRandom _initSecureRandom() {
    //INIT SECURE RANDOM "FORTUNA".
    //Once seeded will produce an indefinite quantity of pseudo-random data.
    final sGen = Random.secure();
    final randSeed =
        Uint8List.fromList(List.generate(32, (n) => sGen.nextInt(255)));
    final secureRandom = FortunaRandom()..seed(KeyParameter(randSeed));
    return secureRandom;
  }

  static ECDomainParametersImpl _initCurveSeeded(List<int> seed) {
    var secp256k1 = ECCurve_secp256k1();
    var domainParams = ECDomainParametersImpl(secp256k1.domainName,
        secp256k1.curve, secp256k1.G, secp256k1.n, secp256k1.h, seed);
    return domainParams;
  }

  static ECKeyGenerator _initKeyGenerator(
      ECDomainParametersImpl domainParams, SecureRandom secureRandom) {
    var keyParams = ECKeyGeneratorParameters(domainParams);
    var paramsWithRandom =
        ParametersWithRandom<ECKeyGeneratorParameters>(keyParams, secureRandom);
    var generator = ECKeyGenerator();
    generator.init(paramsWithRandom);
    return generator;
  }
}
