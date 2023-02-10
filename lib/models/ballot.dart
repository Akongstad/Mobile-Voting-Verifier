import 'package:mobile_voting_verifier/models/multi_ciphertext.dart';
import 'package:mobile_voting_verifier/models/proof.dart';

class Ballot<GroupElem> {
  final MultiCiphertext<GroupElem> encryptedChoice;
  final List<Proof> proofOfKnowledgeOfEncryptionCoins;
  final Proof proofOfKnowledgeOfPrivateCredential;

  Ballot({
    required this.encryptedChoice,
    required this.proofOfKnowledgeOfEncryptionCoins,
    required this.proofOfKnowledgeOfPrivateCredential,
  });
}
