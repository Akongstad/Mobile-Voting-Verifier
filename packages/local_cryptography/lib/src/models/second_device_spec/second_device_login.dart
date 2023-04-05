class SecondDeviceLogin {
  final String challengeCommitment;
  final String nonce;
  final String password;
  final String voterId;

  SecondDeviceLogin({
    required this.challengeCommitment,
    required this.nonce,
    required this.password,
    required this.voterId,
  });

  SecondDeviceLogin.fromJson(Map<String, dynamic> json)
      : challengeCommitment = json['challengeCommitment'],
        nonce = json['nonce'],
        password = json['password'],
        voterId = json['voterId'];

  Map<String, dynamic> toJson() => {
    'challengeCommitment': challengeCommitment,
    'nonce': nonce,
    'password' : password,
    'voterId' : voterId
  };
}
