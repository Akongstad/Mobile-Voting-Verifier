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
}
