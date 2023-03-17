import 'package:elliptic/elliptic.dart';
import 'package:mobile_voting_verifier/models/algorithms/tonelli_shanks.dart';
import 'package:pointycastle/export.dart';

abstract class ECEncodingAPI {

  // Function to decode from a point on the curve
  static Future<BigInt> decodeFromPoint(BigInt x, BigInt y,
          {int k = 80}) async =>
      (x - BigInt.one) ~/ BigInt.from(k);


  // Function to encode to a point on the curve
  static Future<ECPoint> encodeToPoint(
      BigInt a, BigInt prime, ECDomainParameters ec,
      {int k = 80}) async {
    for (var i = 1; i < k; i++) {
      final x = (a * BigInt.from(k) + BigInt.from(i)) % prime;
      final formattedX = await _formatToCurve(x, ec);
      final solutions = await TonelliShanks.tsSolve(formattedX, prime);
      if (solutions.exists) return ec.curve.createPoint(x, solutions.root1);
    }
    return throw EllipticException(
        "after iterating $k times no solution was found for number $a to be encoded");
  }


// Function to format x for Elliptic curves before solving the Tonelli Shanks algorithm
// Tonelli-Shanks algorithm solves r in (r^2 = n) mod p
  static Future<BigInt> _formatToCurve(
      BigInt x, ECDomainParameters curve) async {
    final a = curve.curve.a!.toBigInteger()!;
    final b = curve.curve.b!.toBigInteger()!;
    final formatted = x.pow(3) + a * x + b;
    return formatted;
  }
}
