import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_cryptography/src/models/models.dart';


Future<SecondDeviceLoginResponse> login(
    http.Client client, SecondDeviceLogin secondDeviceLogin) async {
  //Perform http request
  final response = await client.post(
    Uri.parse('/rest/login'), //TODO change to actual URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: secondDeviceLogin.toJson(),
  );

  if (response.statusCode == 200 &&
      jsonDecode(response.body)["status"] == "OK") {
    //Login succeeded
    return SecondDeviceLoginResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 200) {
    //Login Failed
    return throw ArgumentError("Invalid TOTP Password", "FailedLoginEvent");
  } else {
    return throw ArgumentError(
        "Failed to connect to end-point due to status code: ${response.statusCode}",
        "HTTPConnectionFailedEvent");
  }
}
