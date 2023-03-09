import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';

abstract class HashingAPI {
  static Future<List<int>> encodeString(String s) async => utf8.encode(s);

  static Future<List<int>> encodeInt(int x) async => _int32ToBytesBigEndian(x);

  static Future<List<int>> encodeBigInt(BigInt bigInt) async =>
      _bigIntToBytesPadWithLength(bigInt);

  static Future<List<int>> encodeECPoint(ECPoint point) async =>
      point.getEncoded(true);

  static Future<BigInt> nonUniformHashIntoZq(
      List<int> bytes, ECDomainParameters EC) async {
    final hashedCHex = sha512.convert(bytes);
    final hashedCHexBytes = hashedCHex.bytes;
    final hashedToBigint = await _bytesToBigInt(hashedCHexBytes);
    final hashedToBigintZq = hashedToBigint % EC.n;
    return hashedToBigintZq;
  }

  static Future<BigInt> uniFormHashIntoZq(List<int> bytes) async =>
      throw UnimplementedError();


  /*------------------------------------HELPERS----------------------------------*/
  static Future<Uint8List> _bigIntToBytesPadWithLength(BigInt x) async {
    final bytes = await _bigIntToBytes(x);
    final result =  await _int32ToBytesBigEndian(bytes.length) + bytes;
    return Uint8List.fromList(result);
  }

  static Future<Uint8List> _int32ToBytesBigEndian(int value) async =>
      Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.big);

  /// Convert a bigint to a byte array
  static Future<Uint8List> _bigIntToBytes(BigInt bigInt) async =>
      _hexToBytes(bigInt.toRadixString(16).padLeft(32, "0"));

  /// Converts a hex string to a Uint8List
  static Future<Uint8List> _hexToBytes(String hex) async =>
      Uint8List.fromList(HEX.decode(hex));

  /// Convert a bytes to a bigint
  static Future<BigInt> _bytesToBigInt(List<int> bytes) async =>
      BigInt.parse(HEX.encode(bytes), radix: 16);
}
