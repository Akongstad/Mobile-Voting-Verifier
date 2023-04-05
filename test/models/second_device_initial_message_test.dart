import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hex/hex.dart';
import 'package:local_cryptography/local_cryptography.dart';


main() {
  final expectedSecondDeviceInitMessage = SecondDeviceInitialMsg<String>(
      ballot: Ballot(
          encryptedChoice: MultiCiphertext<String>(ciphertexts: [
            Ciphertext<String>(
                x: "03bf956c38e14a6f81ed3621e165fb8c6000c28738f0e279fa28d2254d6b799eb1",
                y: "02e19fbd88d9e1ad760653dde8e7f00fcc0d45e2b38ccc0cb2301f2239d4fcac3f")
          ]),
          proofOfKnowledgeOfEncryptionCoins: [
            Proof(
                c: BigInt.parse(
                    "79966540728819921955585823592173536360716995948664894735154654897488787881072",
                    radix: 10),
                f: BigInt.parse(
                    "90388416755735603296616014607154433872748203957820626540975447356971608146868",
                    radix: 10))
          ],
          proofOfKnowledgeOfPrivateCredential: Proof(
              c: BigInt.parse(
                  "4219105992081372606513358125198075081967495840895255912931536426010398533192",
                  radix: 10),
              f: BigInt.parse(
                  "110464010855198853861051741469261963282081696331616030540127604123885412224008",
                  radix: 10))),
      comSeed: Uint8List.fromList(HEX.decode(
          "a240ec46ff7adefb01b5b8d6fade3c96cb50c40f737a3cffbd98a0e9e6415ea2")),
      factorX: [
        "03aacd547442d178a6fd95d949d84ecc17bbf16bb2428b7598f6abce29a1459a5a"
      ],
      factorY: [
        "0228136a113abad456a2cb690b4a38cea7ef3ba7839b74550aa5bc53a5af88a868"
      ],
      factorA: [
        "0340abe2067662ca5b3b2d122e4aaf7971db4209763ee8949d506e8c974e6c2ddd"
      ],
      factorB: [
        "026bcbe81a01c159c9e42045dbded1ca37ac0d664e3fe3e24bac342c4db28c8647"
      ],
      publicCredential:
      "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e",
      secondDeviceParametersJson: "{\"publicKey\":\"030588c6c80497da9e50bf56a4853c9fd3dd945a5e2ed741ccf783c5538611da26\",\"verificationKey\":\"30820122300d06092a864886f70d01010105000382010f003082010a0282010100a52865923e9a08c8e58c0beacd3f40391f980b7db7a87c626d68dbf2a2a28a848402e5adc7ae7d3afef34b697bcf26e5c29b3be55850f2c7a308d90573d6b3788339104fc7579b07b483ccafa11f12ad123f6eaeb3a64a5cdc3f944ed613d5ad1bb6f8cbb704682d16391f731fac0c87dfe84859c9c9fd690a57cbe7a7bdf3a69d3e8457a1afd88112bf44538b6a04809b3e61ef9608c24ef1f02d6796e73bbeff49efca7a9cf443e36791bce307323d1a05f7fd8d8697b820f632eb50b19a2b4f20c958e193ec80b269e4a1b322bbd2a9d27ba91e7e1f5440bf944cdb1658f5d6d612a0b1d838cbbe19640fd4c5d967b03b95c388910c6ce0c3ecd9340af3f90203010001\",\"ballots\":[{\"type\":\"STANDARD_BALLOT\",\"id\":\"A\",\"title\":{\"default\":\"Ballot title\",\"value\":{}},\"lists\":[{\"id\":\"A1\",\"title\":{\"default\":\"First question!\",\"value\":{}},\"columnHeaders\":[{\"default\":\"\",\"value\":{}}],\"candidates\":[{\"id\":\"A1-1\",\"columns\":[{\"value\":{\"default\":\"Yes\",\"value\":{}},\"contentType\":\"TEXT\"}],\"maxVotes\":1,\"minVotes\":0},{\"id\":\"A1-2\",\"columns\":[{\"value\":{\"default\":\"No\",\"value\":{}},\"contentType\":\"TEXT\"}],\"maxVotes\":1,\"minVotes\":0}],\"maxVotesOnList\":1,\"minVotesOnList\":1,\"maxVotesForList\":0,\"minVotesForList\":0,\"voteCandidateXorList\":false}],\"showInvalidOption\":true,\"showAbstainOption\":false,\"maxVotes\":1,\"minVotes\":0,\"prohibitMoreVotes\":false,\"prohibitLessVotes\":false,\"calculateAvailableVotes\":false}]}",
      signatureHex:
      "529f3e8c7d1f0e2c8061526d8e1d8000c24ab60b32b3bda0ce959788483f977fb12da70ccb7ac154a698ef925cf7ca52e142f8eb22d23e5ccd42b63da227230bf886b13211f5c1f618a946a64f8566fd36849b46a156d4a35288204fd7b22e15fcdce8884b5d6e5c69b07ca271332ba14eced079402c735db642b82ae7478fe2efe849d8c50ba11b7d6985486607a54ea42c6394dc2060ac58cfa9c69cc750816dad43fb74d113ab7bc014e619649688fdbf96a29c894fa2cfc5d2bac8b897d0c8dbb3b79e5c17a90913dcb4ba583ea90e706891d38278745c1b4856f88d045c38b840d4fd427291187c250b2ed7bc846fa25440e98d3e9832f2047e52bc5207");

  group('SecondDeviceInitialMessage fromJson and fromJsonString Tests', () {
    test('isValid returns false if code not valid', () {
      //Arrange
      final actual = SecondDeviceInitialMsg.fromJsonString(
          "{\"secondDeviceParametersJson\":\"{\\\"publicKey\\\":\\\"030588c6c80497da9e50bf56a4853c9fd3dd945a5e2ed741ccf783c5538611da26\\\",\\\"verificationKey\\\":\\\"30820122300d06092a864886f70d01010105000382010f003082010a0282010100a52865923e9a08c8e58c0beacd3f40391f980b7db7a87c626d68dbf2a2a28a848402e5adc7ae7d3afef34b697bcf26e5c29b3be55850f2c7a308d90573d6b3788339104fc7579b07b483ccafa11f12ad123f6eaeb3a64a5cdc3f944ed613d5ad1bb6f8cbb704682d16391f731fac0c87dfe84859c9c9fd690a57cbe7a7bdf3a69d3e8457a1afd88112bf44538b6a04809b3e61ef9608c24ef1f02d6796e73bbeff49efca7a9cf443e36791bce307323d1a05f7fd8d8697b820f632eb50b19a2b4f20c958e193ec80b269e4a1b322bbd2a9d27ba91e7e1f5440bf944cdb1658f5d6d612a0b1d838cbbe19640fd4c5d967b03b95c388910c6ce0c3ecd9340af3f90203010001\\\",\\\"ballots\\\":[{\\\"type\\\":\\\"STANDARD_BALLOT\\\",\\\"id\\\":\\\"A\\\",\\\"title\\\":{\\\"default\\\":\\\"Ballot title\\\",\\\"value\\\":{}},\\\"lists\\\":[{\\\"id\\\":\\\"A1\\\",\\\"title\\\":{\\\"default\\\":\\\"First question!\\\",\\\"value\\\":{}},\\\"columnHeaders\\\":[{\\\"default\\\":\\\"\\\",\\\"value\\\":{}}],\\\"candidates\\\":[{\\\"id\\\":\\\"A1-1\\\",\\\"columns\\\":[{\\\"value\\\":{\\\"default\\\":\\\"Yes\\\",\\\"value\\\":{}},\\\"contentType\\\":\\\"TEXT\\\"}],\\\"maxVotes\\\":1,\\\"minVotes\\\":0},{\\\"id\\\":\\\"A1-2\\\",\\\"columns\\\":[{\\\"value\\\":{\\\"default\\\":\\\"No\\\",\\\"value\\\":{}},\\\"contentType\\\":\\\"TEXT\\\"}],\\\"maxVotes\\\":1,\\\"minVotes\\\":0}],\\\"maxVotesOnList\\\":1,\\\"minVotesOnList\\\":1,\\\"maxVotesForList\\\":0,\\\"minVotesForList\\\":0,\\\"voteCandidateXorList\\\":false}],\\\"showInvalidOption\\\":true,\\\"showAbstainOption\\\":false,\\\"maxVotes\\\":1,\\\"minVotes\\\":0,\\\"prohibitMoreVotes\\\":false,\\\"prohibitLessVotes\\\":false,\\\"calculateAvailableVotes\\\":false}]}\",\"comSeed\":\"a240ec46ff7adefb01b5b8d6fade3c96cb50c40f737a3cffbd98a0e9e6415ea2\",\"publicCredential\":\"0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e\",\"ballot\":{\"encryptedChoice\":{\"ciphertexts\":[{\"x\":\"03bf956c38e14a6f81ed3621e165fb8c6000c28738f0e279fa28d2254d6b799eb1\",\"y\":\"02e19fbd88d9e1ad760653dde8e7f00fcc0d45e2b38ccc0cb2301f2239d4fcac3f\"}]},\"proofOfKnowledgeOfEncryptionCoins\":[{\"c\":\"79966540728819921955585823592173536360716995948664894735154654897488787881072\",\"f\":\"90388416755735603296616014607154433872748203957820626540975447356971608146868\"}],\"proofOfKnowledgeOfPrivateCredential\":{\"c\":\"4219105992081372606513358125198075081967495840895255912931536426010398533192\",\"f\":\"110464010855198853861051741469261963282081696331616030540127604123885412224008\"}},\"signatureHex\":\"529f3e8c7d1f0e2c8061526d8e1d8000c24ab60b32b3bda0ce959788483f977fb12da70ccb7ac154a698ef925cf7ca52e142f8eb22d23e5ccd42b63da227230bf886b13211f5c1f618a946a64f8566fd36849b46a156d4a35288204fd7b22e15fcdce8884b5d6e5c69b07ca271332ba14eced079402c735db642b82ae7478fe2efe849d8c50ba11b7d6985486607a54ea42c6394dc2060ac58cfa9c69cc750816dad43fb74d113ab7bc014e619649688fdbf96a29c894fa2cfc5d2bac8b897d0c8dbb3b79e5c17a90913dcb4ba583ea90e706891d38278745c1b4856f88d045c38b840d4fd427291187c250b2ed7bc846fa25440e98d3e9832f2047e52bc5207\",\"factorX\":[\"03aacd547442d178a6fd95d949d84ecc17bbf16bb2428b7598f6abce29a1459a5a\"],\"factorY\":[\"0228136a113abad456a2cb690b4a38cea7ef3ba7839b74550aa5bc53a5af88a868\"],\"factorA\":[\"0340abe2067662ca5b3b2d122e4aaf7971db4209763ee8949d506e8c974e6c2ddd\"],\"factorB\":[\"026bcbe81a01c159c9e42045dbded1ca37ac0d664e3fe3e24bac342c4db28c8647\"]}");

      //Assert second SecondDeviceInitialMessage fields
      expect(actual.publicCredential,
          expectedSecondDeviceInitMessage.publicCredential);
      expect(actual.comSeed, expectedSecondDeviceInitMessage.comSeed);

      expect(
          actual.factorA.first, expectedSecondDeviceInitMessage.factorA.first);
      expect(
          actual.factorB.first, expectedSecondDeviceInitMessage.factorB.first);
      expect(
          actual.factorX.first, expectedSecondDeviceInitMessage.factorX.first);
      expect(
          actual.factorY.first, expectedSecondDeviceInitMessage.factorY.first);

      expect(actual.signatureHex, expectedSecondDeviceInitMessage.signatureHex);

      //Assert SecondDeviceInitialMessage.ballots
      expect(actual.ballot.encryptedChoice.auxData,
          expectedSecondDeviceInitMessage.ballot.encryptedChoice.auxData);
      expect(actual.ballot.encryptedChoice.ciphertexts.first.x,
          expectedSecondDeviceInitMessage.ballot.encryptedChoice.ciphertexts
              .first.x);
      expect(actual.ballot.encryptedChoice.ciphertexts.first.y,
          expectedSecondDeviceInitMessage.ballot.encryptedChoice.ciphertexts
              .first.y);

      expect(actual.ballot.proofOfKnowledgeOfPrivateCredential.f,
          expectedSecondDeviceInitMessage.ballot
              .proofOfKnowledgeOfPrivateCredential.f);

      expect(actual.ballot.proofOfKnowledgeOfPrivateCredential.c,
          expectedSecondDeviceInitMessage.ballot
              .proofOfKnowledgeOfPrivateCredential.c);
      expect(actual.ballot.proofOfKnowledgeOfPrivateCredential.f,
          expectedSecondDeviceInitMessage.ballot
              .proofOfKnowledgeOfPrivateCredential.f);

      expect(actual.ballot.proofOfKnowledgeOfEncryptionCoins.first.c,
          expectedSecondDeviceInitMessage.ballot
              .proofOfKnowledgeOfEncryptionCoins.first.c);
      expect(actual.ballot.proofOfKnowledgeOfEncryptionCoins.first.f,
          expectedSecondDeviceInitMessage.ballot
              .proofOfKnowledgeOfEncryptionCoins.first.f);
      expect(actual.secondDeviceParametersJson, expectedSecondDeviceInitMessage.secondDeviceParametersJson);
    });
  });
}
