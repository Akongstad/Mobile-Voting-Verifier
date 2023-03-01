class ImageRef {
  final String alt;
  final String hash;
  final String url;

  ImageRef({
    required this.alt,
    required this.hash,
    required this.url,
  });

  ImageRef.fromJson(Map<String, dynamic> json)
      : alt = json['alt'],
        hash = json['hash'],
        url = json['hash'];
}
