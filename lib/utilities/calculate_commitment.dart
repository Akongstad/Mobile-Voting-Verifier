import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:mobile_voting_verifier/models/challenge_request.dart';

/* Future<(String, ChallengeRequest)> calculateChallengeCommitment() async {
  return throw UnimplementedError(); 
  //The String is the challenge commitment c and the ChallengeRequest is the sampled BigInt e and BigInt r, which should be saved for later use. 
} */

String keyDerivationFunction(
    int returnLength, String initialSeed, String label, String context) {
  var initialSeedEncoded = utf8.encode(initialSeed);
  var labelEncoded = utf8.encode(label);
  var contextEncoded = utf8.encode(context);

  var hmacSha512 = Hmac(sha512, initialSeedEncoded);
  var returnList = List.empty(growable: true);

  for (var i = 0; i < (returnLength / 64).ceil(); i++) {
    returnList.add(hmacSha512
        .convert([
          [i],
          labelEncoded,
          [0x00],
          contextEncoded,
          [returnLength]
        ].expand((x) => x).toList())
        .toString());
  }

  var returnString = '';
  for (var element in returnList.sublist(0, (returnLength / 64).ceil() - 1)) {
    returnString += element;
  }

  return returnString +
      returnList.last.toString().substring(0, (returnLength % 64) * 2);
}
