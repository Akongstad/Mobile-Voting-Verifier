import 'package:mobile_voting_verifier/models/ciphertext.dart';

class MultiCiphertext<GroupElement> {
  final Map<String, String>? auxData;
  final List<Ciphertext> ciphertexts;

  MultiCiphertext({
    this.auxData,
    required this.ciphertexts,
  });
}
