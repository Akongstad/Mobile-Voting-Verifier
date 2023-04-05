import 'package:local_cryptography/src/models/models.dart';

class Document {
  final Map<String, String> data;
  final List<Node> nodes;
  final ObjectType object;

  Document({
    required this.data,
    required this.nodes,
    required this.object,
  });
}
