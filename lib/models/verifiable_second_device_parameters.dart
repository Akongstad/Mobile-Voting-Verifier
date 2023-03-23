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


  //------UTILITIES for checking integrity of second device parameters----------
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
  * Verification procedure for preconfigured parameters
  * The fingerprint FINGERPRINT is in fact the SHA512 hash of PUBLIC_PARAMETERS_JSON
  */
  static Future<bool> verifyFingerprint() async {
    final paramsJson = await jsonFromFile("assets/public_parameters.json");
    var paramsBytes = utf8.encode(paramsJson["publicParametersJson"]);
    const Hash algorithm = sha512;
    var paramsSHA512 = algorithm.convert(paramsBytes);

    return paramsSHA512.toString() == paramsJson["fingerprint"];
  }
  /*
  * The verification procedure for parameters from the SecondDeviceInitialMsg
  * The fingerprint is in fact the SHA256 hash of secondDevicePublicParameters
  * from SecondDeviceInitialMsg
  */
  static Future<bool> verifySecondDeviceParameters(String secondDevicePublicParameters) async {
    final paramsJson = await jsonFromFile("assets/public_parameters.json");
    var fingerprint = paramsJson["fingerprint"];

    var paramsBytes = utf8.encode(secondDevicePublicParameters);
    const Hash algorithm = sha512;
    var paramsSHA512 = algorithm.convert(paramsBytes);

    return paramsSHA512.toString() == fingerprint;
  }
}
