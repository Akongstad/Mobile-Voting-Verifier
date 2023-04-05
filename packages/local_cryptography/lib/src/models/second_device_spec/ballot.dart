import 'package:local_cryptography/src/models/models.dart';

class Ballot<T> {
  final MultiCiphertext<T> encryptedChoice;
  final List<Proof> proofOfKnowledgeOfEncryptionCoins;
  final Proof proofOfKnowledgeOfPrivateCredential;

  Ballot({
    required this.encryptedChoice,
    required this.proofOfKnowledgeOfEncryptionCoins,
    required this.proofOfKnowledgeOfPrivateCredential,
  });

  Ballot.fromJson(Map<String, dynamic> json)
      :
        encryptedChoice = MultiCiphertext.fromJson(json["encryptedChoice"]),
        proofOfKnowledgeOfEncryptionCoins = (json["proofOfKnowledgeOfEncryptionCoins"] as List)
            .map((e) => Proof.fromJson(e))
            .toList(),
        proofOfKnowledgeOfPrivateCredential = Proof.fromJson(json["proofOfKnowledgeOfPrivateCredential"]);
}
