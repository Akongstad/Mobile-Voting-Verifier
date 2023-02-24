class SecondDeviceFinalMsg {
  final List<BigInt> z;

  SecondDeviceFinalMsg({
    required this.z,
  });

  factory SecondDeviceFinalMsg.fromJson(Map<String, dynamic> json) {
    var list = json['value']['z'] as List;

    List<BigInt> intList = list.map((e) => BigInt.parse(e)).toList();

    return SecondDeviceFinalMsg(
      z: intList,
    );
  }
}
