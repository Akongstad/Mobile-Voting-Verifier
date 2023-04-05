class ChallengeRequest {
  final BigInt challenge;
  final BigInt challengeRandomCoin;

  ChallengeRequest(
      {required this.challenge, required this.challengeRandomCoin});

  //Parse from JSON to ChallengeRequest
  ChallengeRequest.fromJson(Map<String, dynamic> json)
      : challenge = json['challenge'],
        challengeRandomCoin = json['challengeRandomCoin'];

  Map<String, dynamic> toJson() => {
        'challenge': challenge,
        'challengeRandomCoin': challengeRandomCoin,
      };
}
