import '../domain/enums/network_failure_enum.dart';

class NetworkExceptionToMessageMapper {
  static String map(Object type) {
    switch (type) {
      case NetworkFailureEnum.connectionError:
        return "Connection error";
      case NetworkFailureEnum.connectionTimeOut:
        return "Connection time out";
      case NetworkFailureEnum.serverNotResponding:
        return "Server not responding";
      case NetworkFailureEnum.badCertificate:
        return "Bad certificate";
      case NetworkFailureEnum.badRequest:
        return "Bad request";
      case NetworkFailureEnum.badResponse:
        return "Bad response";
      case NetworkFailureEnum.cancel:
        return "Request canceled";
      case NetworkFailureEnum.unAuthorized:
        return "Unauthorized";
      case NetworkFailureEnum.notFound:
        return "Not found";
      case NetworkFailureEnum.serverError:
        return "Server error";
      default:
        return "Unknown error occurred!";
    }
  }
}
