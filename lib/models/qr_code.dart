class QRCode{
  final String? url;
  final String c;
  final String vid;
  final String nonce;

  QRCode({required this.c, this.url, required this.vid, required this.nonce});

  //Expects
  factory QRCode.fromString(String input){
    //Split qr on parametar values.
    var pattern = r'(\?c=|&vid=|&nonce=)';
    var regex = RegExp(pattern);
    var qrArr = input.split(regex);
    if (qrArr.length != 4) return throw ArgumentError("Too many/too few Qr parameters");
    return QRCode(url: qrArr[0], c: qrArr[1], vid: qrArr[2], nonce: qrArr[3]);
  }

  // Utility methods
  static Future<bool> isValidAsync(String qr) async {
    //Split qr on parametar values.
    var pattern = r'(?c=|&vid=|&nonce=)';
    var regex = RegExp(pattern);
    var qrArr = qr.split(regex);

    //Extract values
    return !(qrArr.length != 4);
  }

  static bool isValid(String qr)  {
    //Split qr on parametar values.
    var pattern = r'(\?c=|&vid=|&nonce=)';
    var regex = RegExp(pattern);
    var qrArr = qr.split(regex);

    //Extract values
    return !(qrArr.length != 4);
  }
}