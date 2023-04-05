class Proof {
  final BigInt c;
  final BigInt f;

  Proof({
    required this.c,
    required this.f,
  });

  Proof.fromJson(Map<String, dynamic> json)
      : c = BigInt.parse(json["c"], radix: 10),
        f = BigInt.parse(json["f"], radix: 10);
}
