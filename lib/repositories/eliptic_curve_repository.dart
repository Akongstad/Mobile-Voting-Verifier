import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

abstract class IEllipticCurveRepository {
  // The seed used to generate the curve, if any.
  String? seed;

  // The random number generator used for key generation.
  SecureRandom get random;

  // The domain parameters for the curve.
  ECDomainParameters get curve;

  // The key generator for the curve.
  ECKeyGenerator get generator;

  // A compressed representation of the number k.
  static final BigInt compressedK = BigInt.parse(
      "0373744f99d31509eb5f8caaabc0cc3fab70e571a5db4d762020723b9cd6ada260",
      radix: 16);

  // A compressed representation of the point G on the curve.
  static final BigInt compressedG = BigInt.parse(
      "0279BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798",
      radix: 16);

  // The prime number p used by the curve.
  static final BigInt p = BigInt.parse(
      "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
      radix: 16);

  // The order of the curve.
  static final BigInt q = BigInt.parse(
      "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141",
      radix: 16);

  // Creates a new instance of the EllipticCurveRepository class using a given seed.
  factory IEllipticCurveRepository.fromSeed(String seed) = EllipticCurveRepository.fromSeed;

  // Creates a new instance of the EllipticCurveRepository class with a random seed.
  factory IEllipticCurveRepository.noSeed() = EllipticCurveRepository.noSeed;
}

// Represents an elliptic curve with key generation capabilities.
class EllipticCurveRepository implements IEllipticCurveRepository {
  // The seed used to generate the curve, if any.
  final String? seed;

  // The random number generator used for key generation.
  final SecureRandom random;

  // The domain parameters for the curve.
  final ECDomainParameters curve;

  // The key generator for the curve.
  final ECKeyGenerator generator;

  // Creates a new instance of the EllipticCurveRepository class using a given seed.
  EllipticCurveRepository.fromSeed(String this.seed)
      : random = _initSecureRandom(),
        curve = _initCurveSeeded(utf8.encode(seed)),
        generator = _initKeyGenerator(
            _initCurveSeeded(utf8.encode(seed)), _initSecureRandom());

  // Creates a new instance of the EllipticCurveRepository class with a random seed.
  EllipticCurveRepository.noSeed()
      : seed = null,
        random = _initSecureRandom(),
        curve = ECCurve_secp256k1(),
        generator = _initKeyGenerator(
            ECCurve_secp256k1(), _initSecureRandom());

  // Initializes the secure random number generator.
    static SecureRandom _initSecureRandom() {
    //INIT SECURE RANDOM "FORTUNA".
    //Once seeded will produce an indefinite quantity of pseudo-random data.
    final sGen = Random.secure();
    final randSeed =
        Uint8List.fromList(List.generate(32, (n) => sGen.nextInt(255)));
    final secureRandom = FortunaRandom()..seed(KeyParameter(randSeed));
    return secureRandom;
  }

  // Initializes an elliptic curve domain parameters object using the secp256k1 curve and a given seed.
  static ECDomainParametersImpl _initCurveSeeded(List<int> seed) {
    var secp256k1 = ECCurve_secp256k1();
    var domainParams = ECDomainParametersImpl(secp256k1.domainName,
        secp256k1.curve, secp256k1.G, secp256k1.n, secp256k1.h, seed);
    return domainParams;
  }

// Initializes an elliptic curve key generator using the given domain parameters and secure random number generator.
  static ECKeyGenerator _initKeyGenerator(
      ECDomainParametersImpl domainParams, SecureRandom secureRandom) {
    var keyParams = ECKeyGeneratorParameters(domainParams);
    var paramsWithRandom =
    ParametersWithRandom<ECKeyGeneratorParameters>(keyParams, secureRandom);
    var generator = ECKeyGenerator();
    generator.init(paramsWithRandom);
    return generator;
  }

  @override
  set seed(String? _seed) {
    seed = _seed;
  }
}
