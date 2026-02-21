import 'package:dio/dio.dart';
import 'package:pokemon/shared/domain/enums/network_failure_enum.dart';

class DioExceptionToNetworkEnumMapper {
  static NetworkFailureEnum map(Object e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
          return NetworkFailureEnum.connectionTimeOut;
        case DioExceptionType.connectionError:
          return NetworkFailureEnum.connectionError;
        case DioExceptionType.receiveTimeout:
          return NetworkFailureEnum.serverNotResponding;
        case DioExceptionType.badResponse:
          return _handleStatusCode(e.response?.statusCode);
        case DioExceptionType.cancel:
          return NetworkFailureEnum.cancel;
        default:
          return NetworkFailureEnum.unknown;
      }
    } else {
      return NetworkFailureEnum.unknown;
    }
  }

  static NetworkFailureEnum _handleStatusCode(int? code) {
    switch (code) {
      case 400:
        return NetworkFailureEnum.badRequest;
      case 401:
        return NetworkFailureEnum.unAuthorized;
      case 404:
        return NetworkFailureEnum.notFound;
      case 500:
        return NetworkFailureEnum.serverError;
      default:
        return NetworkFailureEnum.unknown;
    }
  }
}
