import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import "dart:typed_data";

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
Future<BigInt> _numberFromSeedAsync((int, List<int>, int) lseedk) async  {
  //Concat seed and i: seed||i
  //String byteArray =  keyDerivationFunction( (l/8).ceil(), k, "generator", "POLYAS");
  // Ignore the appropriate number of left-most bits from the byte array above,
  final l = lseedk.$1;
  final seed = lseedk.$2;
  final i = lseedk.$3;
  final k = seed.addAll(int32ToBytes(i));
  //final input = keyDerivationFunction(l, k, "generator", "Polyas");
  const input =
      [0x32, 0x88, 0x92, 0x2A, 0x96, 0x65, 0x33, 0xC7, 0x93, 0xED, 0x53, 0x20, 0x45, 0xFF, 0xFC, 0x3C, 0xE6, 0xBA, 0x77, 0xF2, 0x7E, 0x8F, 0x60, 0xC9, 0xA3, 0xD8, 0x22, 0x21, 0xD8, 0x6F, 0x51, 0xDD, 0xA0, 0x07, 0x36, 0xDB, 0xA3, 0xF8, 0xAE, 0x1D, 0x94, 0xB1, 0x75, 0x62, 0xE8, 0x38, 0xD5, 0x7F, 0xB8, 0x54, 0x00, 0xD1, 0x47, 0xC6, 0xE9, 0x58, 0x5E, 0xD4, 0xD8, 0x59, 0xE4, 0x61, 0x20, 0xB2, 0x75];
  var byteArray = input;

  var binArray = byteArray   //O(the number fo bytes)!!!!
      .map((e) => e.toRadixString(2).padLeft(8, "0"))
      .join();

  var bitLenght = byteArray.length * 8;
  var excessBits = bitLenght - l;
  if (excessBits > 0) {
    binArray.replaceRange(0, excessBits, "");
  }
  //Padding for  bytearray to make sure bigint t is not interpreted as a negative integer
  var pad = "0";
  binArray = pad + binArray;
  assert(binArray.length == l + pad.length);

  var n = BigInt.tryParse(binArray, radix: 2);
  if (n == null) {
    throw ArgumentError.value(byteArray);
  }
  return n;
}

Stream<BigInt> numbersFromSeedAsync(int l, List<int> seed) async* {
  var max = pow(2, l);
  var guard = max <= 0 ? (1 << 31) : max;
   for (int i = 1; i < 100000; i++) {
     yield await _numberFromSeedAsync((l, seed, i));
  }
}


Iterable<BigInt> numbersFromSeed(int l, List<int> seed) sync* {
  //Guards: 2^l and maxint32
  var max = pow(2, l);
  var guard = max <= 0 ? (1 << 31) : max;
  for (int i = 1; i < 1000; i++) {
    //Concat seed and i: seed||i
    var k = seed.join("") + i.toString();
    //String byteArray =  keyDerivationFunction( (l/8).ceil(), k, "generator", "POLYAS");
    //
    var input =
        "32 88 92 2A 96 65 33 C7 93 ED 53 20 45 FF FC 3C E6 BA 77 F2 7E 8F 60 C9 A3 D8 22 21 D8 6F 51 DD A0 07 36 DB A3 F8 AE 1D 94 B1 75 62 E8 38 D5 7F B8 54 00 D1 47 C6 E9 58 5E D4 D8 59 E4 61 20 B2 75";
    var byteArray = input.split(" ");
    var binArray = byteArray
        .map((e) => int.parse(e, radix: 16).toRadixString(2).padLeft(8, "0"))
        .join();
    var bitLenght = byteArray.length * 8;
    var excessBits = bitLenght - l;
    if (excessBits > 0) {
      binArray.replaceRange(0, excessBits, "");
    }

    //Padding for  bytearray to make sure bigint t is not interpreted as a negative integer
    var pad = "0";
    binArray = pad + binArray;
    assert(binArray.length == l + pad.length);

    var n = BigInt.tryParse(binArray, radix: 2);
    if (n == null) {
      throw ArgumentError.value(byteArray);
    }
    yield n;
  }
}

/*------------------------------------HELPERS----------------------------------*/
// Magical function from int32 to byte[]
Uint8List int32ToBytes(int value) =>
    Uint8List(4)..buffer.asInt32List()[0] = value;