import 'package:mobile_voting_verifier/models/ciphertext.dart';

class MultiCiphertext<T> {
  final Map<String, String>? auxData;
  final List<Ciphertext> ciphertexts;

  MultiCiphertext({
    this.auxData,
    required this.ciphertexts,
  });

  MultiCiphertext.fromJson(Map<String, dynamic> json)
      : auxData = json["auxData"] != null
            ? json["auxData"] as Map<String, String>
            : null,
        ciphertexts = (json["ciphertexts"] as List)
            .map((e) => Ciphertext.fromJson(e))
            .toList();
}
