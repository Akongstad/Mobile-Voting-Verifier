import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

import 'package:mobile_voting_verifier/models/core_3_ballot.dart';

class VerifiableSecondDeviceParameters {
  final String publicKey;
  final String verificationKey;
  final List<Core3Ballot> ballots;

  VerifiableSecondDeviceParameters({
    required this.ballots,
    required this.publicKey,
    required this.verificationKey,
  });

  VerifiableSecondDeviceParameters.fromJson(Map<String, dynamic> json)
      : publicKey = json["publicKey"],
        verificationKey = json["verificationKey"],
        ballots = (json["ballots"] as List)
            .map((e) => Core3Ballot.fromJson(e))
            .toList();

  factory VerifiableSecondDeviceParameters.fromString(String jsonString) =>
      VerifiableSecondDeviceParameters.fromJson(json.decode(jsonString));

  /*
  * Read jsonObject from file.
  * Used with verify hash to verify public parameters fingerprint.
  */
  static Future<Map<String, dynamic>> jsonFromFile(String filepath) async {
    try{
      var publicParametersString = await rootBundle.loadString(filepath);
      return jsonDecode(publicParametersString);
    } catch (e) {
      print(e);
      return throw FileSystemException("Failed to read or locate public_parameters.json", filepath);
    }
  }

  /*
  * The verification procedure check 1
  * The fingerprint FINGERPRINT is in fact the SHA256 hash of PUBLIC_PARAMETERS_JSON
  */
  static Future<bool> verifyHash() async {
    final paramsJson = await jsonFromFile("assets/public_parameters.json");
    var paramsBytes = utf8.encode(paramsJson["publicParametersJson"]);
    const Hash algorithm = sha256;
    var paramsSHA256 = algorithm.convert(paramsBytes);

    return paramsSHA256.toString() == paramsJson["fingerprint"];
  }
}
