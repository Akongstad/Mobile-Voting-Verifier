class Ciphertext<T> {
  //ElGamal ciphertext over the given set of group elements T
  final T x;
  final T y;

  Ciphertext({
    required this.x,
    required this.y,
  });
  Ciphertext.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'];
}
