import '../utils/constants.dart';

class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message ?? ErrorMessages.serverError);
}
