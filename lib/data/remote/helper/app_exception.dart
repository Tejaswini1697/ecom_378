class AppException implements Exception {
  String title;
  String msg;

  AppException({required this.title, required this.msg});

  @override
  String toString() {
    return "Exception: $title : $msg";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String desc})
    : super(title: "FetchDataException", msg: desc);
}

class BadRequestException extends AppException {
  BadRequestException({required String desc})
    : super(title: "BadRequestException", msg: desc);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({required String desc})
    : super(title: "UnAuthorizedException", msg: desc);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String desc})
    : super(title: "InvalidInputException", msg: desc);
}

class ServerException extends AppException {
  ServerException({required String desc})
    : super(title: "ServerException", msg: desc);
}

class NoInternetException extends AppException {
  NoInternetException({required String desc})
    : super(title: "NoInternetException", msg: desc);
}
