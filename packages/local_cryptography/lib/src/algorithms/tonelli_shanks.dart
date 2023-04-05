abstract class TonelliShanks {
  static Future<TSSolution> tsSolve(BigInt n, BigInt p) async {
    // Return “not a square”, because n is not a square modulo p by Euler’s theorem
    if (n.modPow((p - BigInt.one) ~/ BigInt.two, p) != BigInt.one) {
      return TSSolution(root1: BigInt.zero, root2: BigInt.zero, exists: false);
    }

    BigInt q = p - BigInt.one;
    BigInt ss = BigInt.zero;
    while ((q & BigInt.one) == BigInt.zero) {
      ss = ss + BigInt.one;
      q = q >> 1;
    }
    if (ss == BigInt.one) {
      BigInt r1 = n.modPow((p + BigInt.one) ~/ BigInt.from(4), p);
      return TSSolution(root1: r1, root2: p - r1, exists: true);
    }

    BigInt z = BigInt.two;
    while (z.modPow((p - BigInt.one) ~/ BigInt.two, p) != p - BigInt.one) {
      z += BigInt.one;
    }
    BigInt c = z.modPow(q, p);
    BigInt r = n.modPow((q + BigInt.one) ~/ BigInt.two, p);
    BigInt t = n.modPow(q, p);
    BigInt m = ss;

    while (true) {
      if (t == BigInt.one) {
        return TSSolution(root1: r, root2: p - r, exists: true);
      }
      BigInt i = BigInt.zero;
      BigInt zz = t;

      while (zz != BigInt.one && i < (m - BigInt.one)) {
        zz = zz * zz % p;
        i += BigInt.one;
      }
      BigInt b = c;
      BigInt e = m - i - BigInt.one;
      while (e > BigInt.zero) {
        b = b * b % p;
        e -= BigInt.one;
      }
      r = r * b % p;
      c = b * b % p;
      t = t * c % p;
      m = i;
    }
  }
}

class TSSolution {
  final BigInt root1;
  final BigInt root2;
  final bool exists;
  TSSolution({required this.root1, required this.root2, required this.exists});
}
