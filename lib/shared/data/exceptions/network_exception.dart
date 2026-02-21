import '../../domain/enums/network_failure_enum.dart';

class NetworkException implements Exception {
  final NetworkFailureEnum type;

  NetworkException(this.type);
}
