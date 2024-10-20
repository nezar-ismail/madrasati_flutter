class InternalException implements Exception {
  final String message;

  InternalException(this.message);

  @override
  String toString() {
    return 'InternalException: $message';
  }
}
