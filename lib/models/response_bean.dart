abstract class ResponseBean {}

class Error extends ResponseBean {
  final String error;
  final status = "ERROR";

  Error({
    required this.error,
  });
}

class OK<T> extends ResponseBean {
  final T value;
  final status = "OK";

  OK({
    required this.value,
  });
}
