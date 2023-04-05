import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:local_cryptography/src/models/second_device_spec/ballot.dart';

// Ballot has GroupElems.
// GroupElems = encoded ECPoints.
class SecondDeviceInitialMsg<T> {
  final Ballot<String> ballot; // G
  final Uint8List comSeed;
  final List<String> factorA; // G
  final List<String> factorB; // G
  final List<String> factorX; // G
  final List<String> factorY; // G
  final String publicCredential; // G
  final String secondDeviceParametersJson;
  final String signatureHex;

  SecondDeviceInitialMsg({
    required this.ballot,
    required this.comSeed,
    required this.factorA,
    required this.factorB,
    required this.factorX,
    required this.factorY,
    required this.publicCredential,
    required this.secondDeviceParametersJson,
    required this.signatureHex,
  });

  // Constructor treating groupelems as strings
  factory SecondDeviceInitialMsg.fromJson(Map<String, dynamic> json) {
    return SecondDeviceInitialMsg(
        ballot: Ballot<String>.fromJson(json["ballot"]),
        comSeed: Uint8List.fromList(HEX.decode(json["comSeed"])),
        factorA: (json["factorA"] as List).map((e) => e as String).toList(),
        factorB: (json["factorB"] as List).map((e) => e as String).toList(),
        factorX: (json["factorX"] as List).map((e) => e as String).toList(),
        factorY: (json["factorY"] as List).map((e) => e as String).toList(),
        publicCredential: json["publicCredential"],
        secondDeviceParametersJson: json["secondDeviceParametersJson"],
        signatureHex: json["signatureHex"]);
  }

  factory SecondDeviceInitialMsg.fromJsonString(String jsonString) =>
      SecondDeviceInitialMsg.fromJson(json.decode(jsonString));
}
