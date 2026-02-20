import '/shared/domain/failure/failure.dart';

class CacheFailure implements Failure {
  final String message;
  CacheFailure([this.message = 'Cache Failure']);
}
