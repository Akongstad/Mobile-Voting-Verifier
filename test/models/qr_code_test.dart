import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/qr_scanner/models/qr_code.dart';

void main() {

  group('QR-Utilities-IsValid', () {
    test('isValid returns false if code not valid', () {
      //Arrange
      final value = QRCode.isValid("");
      //Assert
      expect(value, false);
    });

    test('isValid returns true if code valid', () {
      //Arrange
      const validQr = "URL?c=vtWXj-YxxTV2ektefJ5pk7AWc9saoPbu6wJZUZ9R1t8ekU89x7SCYLcg8ODi3fHST4BTmAK97XN3XqWc"
          "&vid=voter8"
          "&nonce=4bf8cecf3fb4c4b4372005e13a53dce705123fab5b9e9288461e6d8fbf9644ea";
      final value = QRCode.isValid(validQr);
      //Assert
      expect(value, true);
    });
  });
  group('QR-Utilities-getParameters', () {
    test('isValid returns false if code not valid', () {
      //Assert
      expect (() => QRCode.fromString(""), throwsArgumentError);
    });

    test('isValid returns true if code valid', () {
      //Arrange
      const validQr = "URL?c=vtWXj-YxxTV2ektefJ5pk7AWc9saoPbu6wJZUZ9R1t8ekU89x7SCYLcg8ODi3fHST4BTmAK97XN3XqWc"
          "&vid=voter8"
          "&nonce=4bf8cecf3fb4c4b4372005e13a53dce705123fab5b9e9288461e6d8fbf9644ea";
      final actual = QRCode.fromString(validQr);

      //Assert
      expect(actual.url, "URL");
      expect(actual.c, "vtWXj-YxxTV2ektefJ5pk7AWc9saoPbu6wJZUZ9R1t8ekU89x7SCYLcg8ODi3fHST4BTmAK97XN3XqWc");
      expect(actual.vid, "voter8");
      expect(actual.nonce, "4bf8cecf3fb4c4b4372005e13a53dce705123fab5b9e9288461e6d8fbf9644ea");
    });
  });
}