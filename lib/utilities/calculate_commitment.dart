import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:mobile_voting_verifier/models/challenge_request.dart';

/* Future<(String, ChallengeRequest)> calculateChallengeCommitment() async {
  return throw UnimplementedError(); 
  //The String is the challenge commitment c and the ChallengeRequest is the sampled BigInt e and BigInt r, which should be saved for later use. 
} */

List<int> keyDerivationFunction(int returnLength, List<int> initialSeed,
    List<int> label, List<int> context) {
  var hmacSha512 = Hmac(sha512, initialSeed);
  List<List<int>> blockList = List.empty(growable: true);

  for (var i = 0; i < (returnLength / 64).ceil(); i++) {
    blockList.add(hmacSha512
        .convert([
          [i],
          label,
          [0x00],
          context,
          [returnLength]
        ].expand((x) => x).toList())
        .bytes);
  }

  List<int> returnlist = [];

  for (var element in blockList.sublist(0, (returnLength / 64).ceil() - 1)) {
    returnlist.addAll(element);
  }

  for (var i = 0; i < (returnLength % 64); i++) {
    returnlist.add(blockList.last[i]);
  }

  return returnlist;
}
