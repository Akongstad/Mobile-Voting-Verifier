import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';

// Define the HashingAPI interface
abstract class HashingAPI {
  Future<List<int>> encodeString(String s) async => utf8.encode(s);
  Future<List<int>> encodeInt(int x);
  Future<List<int>> encodeBigInt(BigInt bigInt);
  Future<List<int>> encodeECPoint(ECPoint point);
  Future<List<int>> encodeElGamalCipher(BigInt x, BigInt y);
  Future<BigInt> nonUniformHashIntoZq(List<int> bytes, ECDomainParameters ec);
  Future<BigInt> uniFormHashIntoZq(List<int> bytes);
}

// Implement the HashingAPI interface
class DefaultHashingAPI implements HashingAPI {
  @override
  Future<List<int>> encodeString(String s) async => utf8.encode(s);

  @override
  Future<List<int>> encodeInt(int x) async =>
      _int32ToBytesBigEndian(x);

  @override
  Future<List<int>> encodeBigInt(BigInt bigInt) async =>
      _bigIntToBytesPadWithLength(bigInt);

  @override
  Future<List<int>> encodeECPoint(ECPoint point) async =>
      point.getEncoded(true);

  @override
  Future<List<int>> encodeElGamalCipher(BigInt x, BigInt y) async =>
      throw UnimplementedError();

  @override
  Future<BigInt> nonUniformHashIntoZq(
      List<int> bytes, ECDomainParameters ec) async {
    final hashedCHex = sha512.convert(bytes);
    final hashedCHexBytes = hashedCHex.bytes;
    final hashedToBigint = await _bytesToBigInt(hashedCHexBytes);
    final hashedToBigintZq = hashedToBigint % ec.n;
    return hashedToBigintZq;
  }
  @override
  Future<BigInt> uniFormHashIntoZq(List<int> bytes) async =>
      throw UnimplementedError();

  // Specific conversion of BigInt to Uint8List with padding
  static Future<Uint8List> _bigIntToBytesPadWithLength(BigInt x) async {
    final bytes = await _bigIntToBytes(x);
    final result = await _int32ToBytesBigEndian(bytes.length) + bytes;
    return Uint8List.fromList(result);
  }

  /// Convert a int to a Uint8List in endianness big-endian (BE)
  static Future<Uint8List> _int32ToBytesBigEndian(int value) async =>
      Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.big);

  /// Convert a BigInt to a Uint8List
  static Future<Uint8List> _bigIntToBytes(BigInt bigInt) async =>
      hexToBytes(bigInt.toRadixString(16).padLeft(32, "0"));

  /// Converts a hex string to a Uint8List
  static Future<Uint8List> hexToBytes(String hex) async =>
      Uint8List.fromList(HEX.decode(hex));

  /// Converts a byte array to hex String
  static Future<String> bytesToHex(List<int> bytes) async => HEX.encode(bytes);

  /// Convert a byte array to a BigInt
  static Future<BigInt> _bytesToBigInt(List<int> bytes) async =>
      BigInt.parse(HEX.encode(bytes), radix: 16);
  static Future<ECPoint> _bytesToECPoint(
          List<int> bytes, ECDomainParameters curveParams) async =>
      curveParams.curve.decodePoint(bytes)!;
}
