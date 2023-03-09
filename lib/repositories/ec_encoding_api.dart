import 'dart:math';

import 'package:elliptic/elliptic.dart';
import 'package:pointycastle/export.dart';

abstract class ECEncodingAPI {
  //Standard for finite field in secp256k1
  static final specP = BigInt.parse(
      "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
      radix: 16);

  static var z = BigInt.zero;

  // floor is default for bigint division
  static Future<BigInt> decodePoint(BigInt x, BigInt y, {int k = 80}) async =>
      (x - BigInt.one) ~/ BigInt.from(k);


  static Future<ECPoint> encodePoint(
      BigInt a, BigInt prime, ECDomainParameters EC,
      {int k = 80}) async {
    for (var i = 1; i < k; i++) {
      final x = (a * BigInt.from(k) + BigInt.from(i)) % specP;
      final solution = await _solveCurve(x, prime);
      if (solution != BigInt.from(-1)) return EC.curve.createPoint(x,solution);
    }
    return throw EllipticException(
        "after iterating $k times no solution was found for encodePoint($a)");
  }


  // Check for valid solution to curve using Tornelli-Shanks algorithm
  //for finding
  // Modular Square Roots
  //Inspired: https://rosettacode.org/wiki/Tonelli-Shanks_algorithm
  // and https://www.geeksforgeeks.org/find-square-root-modulo-p-set-2-shanks-tonelli-algorithm/
  /* y^2 = x^3 + 7
 * Takes as input an odd prime p and n < p and returns r
 * such that r * r = n [mod p].
 * y^2 = ((a * BigInt.from(k) + BigInt.from(i)) % p) +7;
 */
  static Future<BigInt> _solveCurve(BigInt n, BigInt p) async {
    // a and p should be coprime for
    // finding the modular square root
    if (n.gcd(p)!= BigInt.one)
    {
      print("a and p are not coprime");
      return BigInt.from(-1);
    }
    // If below expression return (p - 1) then
    // modular square root is not possible
    if (n.modPow((p - BigInt.one)~/ BigInt.two, p) == (p - BigInt.one))
    {
      print("no sqrt possible");
      return BigInt.from(-1);
    }
    // expressing p - 1, in terms of s * 2^e,
    //  where s is odd number
    BigInt s = await _convertX2E(p - BigInt.one);
    var e = z;
    // finding smallest q such that q ^ ((p - 1) / 2)
    // (mod p) = p - 1

    BigInt q;
    for (q = BigInt.two; ; q+=BigInt.one)
    {
      // q - 1 is in place of (-1 % p)
      if (q.modPow((p - BigInt.one)~/ BigInt.two, p) == (p - BigInt.one)) break;
    }
    // Initializing variable x, b and g
    var x = n.modPow((s+BigInt.one)~/BigInt.two, p);
    var b = n.modPow(s, p);
    var g = q.modPow(s, p);

    var r = e.toInt();
    // keep looping until b become
    // 1 or m becomes 0
    while (true){
      int m;
      for (m = 0; m < r; m++){
        if (await _order(p, b) == BigInt.from(-1)) return BigInt.from(-1);
        // finding m such that b^ (2^m) = 1
        if (await _order(p,b) == BigInt.two.pow(m)) break;
      }
      if (m == 0) return x;

      // updating value of x, g and b
      // according to algorithm
      x = (x * g.modPow(BigInt.two.pow(r-m-1),p)) % p;
      g = g.modPow(BigInt.two.pow(r-m), p);
      b = (b*g) % p;

      if(b==BigInt.one) return x;
      r = m;
    }
  }

  //-----------------------------------Helpers----------------------------------
  // function return p - 1 (= x argument)
  // as x * 2^e, where x will be odd sending
  // e as reference because updation is
  // needed in actual e
  static Future<BigInt> _convertX2E(BigInt x) async {
    z = BigInt.zero;
    while (x % BigInt.two == BigInt.zero){
      x ~/= BigInt.two;
      z+=BigInt.one;
    }
    return x;
  }

// Returns k such that b^k = 1 (mod p)
  static Future<BigInt> _order(BigInt p, BigInt b) async
  {
    if (p.gcd(b) != BigInt.one)
    {
      print("p and b are" +
          "not co-prime.");
      return BigInt.from(-1);
    }
    // 3 = first odd prime
    var k = BigInt.from(3);
    while (b.modPow(k, p) != BigInt.one)
    {
      k+=BigInt.one;
    }
    return k;
  }
}
