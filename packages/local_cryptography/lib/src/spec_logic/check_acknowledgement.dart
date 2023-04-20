import 'package:local_cryptography/local_cryptography.dart';
import 'package:local_cryptography/src/models/models.dart';

/// check the acknowledgement, that is the signature of the election system on the voter’s ballot
/// Use pointy castle utilities to verify the signature
Future<bool> checkAcknowledgement(SecondDeviceInitialMsg initialMsg) async {
  return throw UnimplementedError();
}

/// Compute the sequence of bytes to be signed (BTBS)
/// The sequence of bytes to be signed is the concatenation of the following:
/// 1. The sequence of bytes representing the public label
/// 2. The sequence of bytes representing the publicCredential
/// 3. The sequence of bytes representing the voterID
Future<List<int>> computeBTBS(
    String publicLabel, String publicCredential, String voterId) async {
  return throw UnimplementedError();
}

Future<List<int>> ballotAsNormalizedByteString(
    List<int> btbs, Ciphertext ciphertext) async {
  return throw UnimplementedError();
}

//--------------------------------HELPERS--------------------------------
/// put denotes appending data to the input byte array
/// putLength denotes appending the binary representation of the given data, prepended with its length.
