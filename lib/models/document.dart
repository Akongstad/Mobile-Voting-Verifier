import 'package:mobile_voting_verifier/models/enums/object_type.dart';
import 'package:mobile_voting_verifier/models/node.dart';

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
