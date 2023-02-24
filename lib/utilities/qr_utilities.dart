Future<bool> isValidAsync(String qr) async {
  //Split qr on parametar values.
  var pattern = r'(?c=|&vid=|&nonce=)';
  var regex = RegExp(pattern);
  var qrArr = qr.split(regex);

  //Extract values
  if (qrArr.length != 4) return false;
  else return true;
}
Future<Map<String, String>> getParametersAsync(String qr) async {
  //Split qr on parametar values.
  var pattern = r'(?c=|&vid=|&nonce=)';
  var regex = RegExp(pattern);
  var qrArr = qr.split(regex);
  //Extract values
  if (qrArr.length != 4) {
    throw ArgumentError();
  } else {
    var map = <String, String>{};
    map['c'] = qrArr[1].trim();
    map['URL'] = qrArr[0].trim();
    map['vid'] = qrArr[2].trim();
    map['nonce'] = qrArr[2].trim();
    return map;
  }
}
bool isValid(String qr)  {
  //Split qr on parametar values.
  var pattern = r'(\?c=|&vid=|&nonce=)';
  var regex = RegExp(pattern);
  var qrArr = qr.split(regex);

  //Extract values
  return !(qrArr.length != 4);
}
Map<String, String> getParameters(String qr)  {
  //Split qr on parametar values.
  var pattern = r'(\?c=|&vid=|&nonce=)';
  var regex = RegExp(pattern);
  var qrArr = qr.split(regex);
  //Extract values
  if (qrArr.length != 4) {
    throw ArgumentError();
  } else {
    var map = <String, String>{};
    map['URL'] = qrArr[0];
    map['c'] = qrArr[1];
    map['vid'] = qrArr[2];
    map['nonce'] = qrArr[3];
    return map;
  }
}
