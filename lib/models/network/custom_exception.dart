class CustomException implements Exception {
  final String errorMessage;
  final String prefix;

  CustomException(this.errorMessage, this.prefix);

  @override
  String toString() {
    return "$prefix$errorMessage";
  }
}

class NotFoundException extends CustomException {
  NotFoundException(String errorMessage) : super(errorMessage, "Not Found: ");
}

class BadRequestException extends CustomException {
  BadRequestException(String errorMessage)
      : super(errorMessage, "Bad Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(String errorMessage)
      : super(errorMessage, "Unauthorized: ");
}

class FetchException extends CustomException {
  FetchException(String errorMessage) : super(errorMessage, "Fetching error: ");
}
