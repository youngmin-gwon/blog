enum Failure {
  cache("internal cache error");

  const Failure(this.message);
  final String message;
}
