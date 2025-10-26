import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioService {
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://pokeapi.co/api/v2/pokemon/",
        receiveTimeout: Duration(seconds: 6),
        sendTimeout: Duration(seconds: 6),
        connectTimeout: Duration(seconds: 12),
      ),
    );
  }
}

final dioProvider = Provider<DioService>((ref) => DioService());
