
class Ciphertext<T> {
  //Hashed Hex Strings.
  final T x;
  final T y;

  Ciphertext({
    required this.x,
    required this.y,
  });
  Ciphertext.fromJson(Map<String, dynamic> json) :
      x = json['x'],
      y = json['y'];
}
