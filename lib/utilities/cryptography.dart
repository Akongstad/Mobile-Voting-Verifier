import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import "dart:typed_data";

/*
Algorithm 1
*/ 

List<int> keyDerivationFunction(int returnLength, List<int> initialSeed,
    List<int> label, List<int> context) {
  var hmacSha512 = Hmac(sha512, initialSeed);
  List<List<int>> blockList = List.empty(growable: true);

  for (var i = 0; i < (returnLength / 64).ceil(); i++) {
    blockList.add(hmacSha512
        .convert([
          _int32ToBytesBigEndian(i),
          label,
          [0x00],
          context,
          _int32ToBytesBigEndian(returnLength)
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

/*
* Algorithm 2
* Input: ----------------------------------------------------------------------
* l: the desired length ; in bits of the generated numbers,
* seed: the initial seed seed, given as a byte array,
* Output: ---------------------------------------------------------------------
* Sequence n1, n2, . . . of numbers in the range [0, 2^l ); the maximal length
* of the output sequence is limited by MAXINT32.
* Considerations: --------------------------------------------------------------
*  Make parrallell
* Use stringBuilder
* Takes a record because compute() only parses 1 argument
*/

Future<BigInt> _numberFromSeedAsync((int, List<int>, int) lSeedI) async  {
  //Concat seed and i: seed||i
  //String byteArray =  keyDerivationFunction( (l/8).ceil(), k, "generator", "POLYAS");
  // Ignore the appropriate number of left-most bits from the byte array above,
  final l = lSeedI.$1;
  final seed = lSeedI.$2;
  final i = lSeedI.$3;
  final k = seed + _int32ToBytesBigEndian(i);

  final input = keyDerivationFunction((l/8).ceil(), k, utf8.encode("generator"), utf8.encode("Polyas"));

  var binArray = input   //O(the number fo bytes)!!!!
      .map((e) => e.toRadixString(2).padLeft(8, "0"))
      .join();

  var bitLenght = input.length * 8;
  var excessBits = bitLenght - l;
  if (excessBits > 0) {
    binArray.replaceRange(0, excessBits, "");
  }
  //Padding for  bytearray to make sure bigint t is not interpreted as a negative integer
  var pad = '0';
  binArray = pad + binArray;
  assert(binArray.length == l + pad.length);

  var n = BigInt.tryParse(binArray, radix: 2);
  if (n == null) {
    throw ArgumentError.value(input);
  }
  return n;
}

Stream<Future<BigInt>> numbersFromSeedFuturesAsync(int l, List<int> seed) async* {
  var max = pow(2, l);
  var guard = max <= 0 ? (1 << 31) : max;
   for (int i = 1; i < 100000; i++) {
     yield _numberFromSeedAsync((l, seed, i));
  }
}

Stream<BigInt> numbersFromSeedAsync(int l, List<int> seed) async* {
  var max = pow(2, l);
  var guard = max <= 0 ? (1 << 31) : max;
  for (int i = 1; i < 100000; i++) {
    yield await _numberFromSeedAsync((l, seed, i));
  }
}

/*------------------------------------HELPERS----------------------------------*/
// Magical function from int32 to byte[] with LittleEndian byte ordering.
Uint8List _int32ToBytesLittleEndian(int value) =>
    Uint8List(4)..buffer.asInt32List()[0] = value;
// Magical function from int32 to byte[] with BigEndian byte ordering.
Uint8List _int32ToBytesBigEndian(int value) =>
    Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.big);