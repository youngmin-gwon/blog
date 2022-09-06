abstract class Failure {
  const Failure();

  const factory Failure.internal(String message) = InternalFailure;
}

class InternalFailure implements Failure {
  const InternalFailure(this.message);

  final String message;
}

String mapFailureToString(Failure failure) {
  // return failure.when(
  //   internal: (String? message) => message ?? "Internal issue has been occured",
  // );

  return "";
}
