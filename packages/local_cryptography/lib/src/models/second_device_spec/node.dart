abstract class Node {}

class Block extends Node {
  final Map<String, String> data;
  final List<Node> nodes;
  final String type;
  final object = "block";

  Block({
    required this.data,
    required this.nodes,
    required this.type,
  });
}

class Inline extends Node {
  final Map<String, String> data;
  final List<Node> nodes;
  final String type;
  final object = "inline";

  Inline({
    required this.data,
    required this.nodes,
    required this.type,
  });
}

class NodeText extends Node {
  final Set<Mark> marks;
  final String text;
  final object = "text";

  NodeText({
    required this.marks,
    required this.text,
  });
}

class Mark {
  final Map<String, String> data;
  final String object;
  final String type;

  Mark({
    required this.data,
    required this.object,
    required this.type,
  });
}
