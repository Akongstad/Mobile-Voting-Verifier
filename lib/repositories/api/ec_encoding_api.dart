import 'package:elliptic/elliptic.dart';
import 'package:mobile_voting_verifier/models/algorithms/tonelli_shanks.dart';
import 'package:pointycastle/export.dart';

abstract class ECEncodingAPI {
  //Standard for finite field in secp256k1
  static final specP = BigInt.parse(
      "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
      radix: 16);

  static var z = BigInt.zero;

  // floor is default for bigint division
  static Future<BigInt> decodeFromPoint(BigInt x, BigInt y,
      {int k = 80}) async =>
      (x - BigInt.one) ~/ BigInt.from(k);


  static Future<ECPoint> encodeToPoint(BigInt a, BigInt prime,
      ECDomainParameters EC,
      {int k = 80}) async {
    for (var i = 1; i < k; i++) {
      final x = (a * BigInt.from(k) + BigInt.from(i)) % prime;
      final formattedX = await _formatToCurve(x, EC);
      final solutions = await TonelliShanks.tsSolve(formattedX, prime);
      if (solutions.exists) return EC.curve.createPoint(x, solutions.root1);
    }
    return throw EllipticException(
        "after iterating $k times no solution was found for encodePoint($a)");
  }
// y^2 = x^3 + ax + b
// x -> x^3 + ax +b
  static Future<BigInt> _formatToCurve(BigInt x, ECDomainParameters curve) async {
    final a = curve.curve.a!.toBigInteger()!;
    final b = curve.curve.b!.toBigInteger()!;
    final formatted = x.pow(3) + a*x + b;
    return formatted;
  }
}
