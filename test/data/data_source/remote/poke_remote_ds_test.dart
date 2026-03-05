import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/features/home/data/datasource/remote/poke_remote_ds_impl.dart';
import 'package:pokemon/shared/data/exceptions/network_exception.dart';
import 'package:pokemon/shared/domain/enums/network_failure_enum.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late PokeRemoteDsImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = PokeRemoteDsImpl(mockDio);
  });

  group('getAllPokemons', () {
    final mockResponseData = {
      'results': [
        {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
        {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
      ],
    };

    test('should return a list of Pokemon, if status code 200', () async {
      // Arrange
      when(
        () => mockDio.get('', queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await dataSource.getAllPokemons();

      // Assert
      expect(result.length, 2);
      expect(result.first.name, 'bulbasaur');
      expect(result.first.id, 1); // i + 1
    });

    test('throw NetworkException if DioException', () async {
      // Arrange
      when(
        () => mockDio.get('', queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      // Act & Assert
      expect(
        () => dataSource.getAllPokemons(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('getPokemonById', () {
    test('should return Pokemon, if status code 200', () async {
      // Arrange
      final pokemonJson = {
        'id': 1,
        'name': 'bulbasaur',
        'sprites': {
          'front_default': 'url',
          'other': {
            'official-artwork': {'front_default': 'url'},
          },
        },
      };

      when(() => mockDio.get('/1')).thenAnswer(
        (_) async => Response(
          data: pokemonJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/1'),
        ),
      );

      // Act
      final result = await dataSource.getPokemonById(1);

      // Assert
      expect(result?.name, 'bulbasaur');
      expect(result?.id, 1);
    });
  });
}
