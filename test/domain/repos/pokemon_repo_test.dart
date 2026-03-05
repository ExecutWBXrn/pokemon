import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/features/home/data/datasource/remote/poke_remote_ds.dart';
import 'package:pokemon/shared/data/models/pokemon.dart';
import 'package:pokemon/features/home/data/repos_impl/pokemon_repo_impl.dart';
import 'package:pokemon/shared/data/exceptions/network_exception.dart';
import 'package:pokemon/shared/domain/enums/network_failure_enum.dart';

class MockPokeRemoteDs extends Mock implements PokeRemoteDs {}

void main() {
  late MockPokeRemoteDs mockRemoteDs;
  late PokemonRepoImpl repo;

  setUp(() {
    mockRemoteDs = MockPokeRemoteDs();
    repo = PokemonRepoImpl(mockRemoteDs);
  });

  group('getAllPokemons', () {
    final tPokemonModel = Pokemon(id: 1, name: 'Pikachu', img: 'url');
    final tPokemonModels = [tPokemonModel];

    test('should return Entity, once Datasource return model', () async {
      // Arrange
      when(
        () => mockRemoteDs.getAllPokemons(),
      ).thenAnswer((_) async => tPokemonModels);

      // Act
      final result = await repo.getAllPokemons();

      // Assert
      expect(result.first.id, tPokemonModel.id);
      expect(result.first.name, tPokemonModel.name);
      verify(() => mockRemoteDs.getAllPokemons()).called(1);
    });

    test(
      'should throw NetworkException, when DS throw NetworkException',
      () async {
        // Arrange
        when(
          () => mockRemoteDs.getAllPokemons(),
        ).thenThrow(NetworkException(NetworkFailureEnum.serverError));

        // Act & Assert
        expect(() => repo.getAllPokemons(), throwsA(isA<NetworkException>()));
      },
    );

    test(
      'should throw NetworkFailureEnum.unknown when unseeable error',
      () async {
        // Arrange
        when(
          () => mockRemoteDs.getAllPokemons(),
        ).thenThrow(Exception('Crash!'));

        // Act & Assert
        try {
          await repo.getAllPokemons();
        } on NetworkException catch (e) {
          expect(e.type, NetworkFailureEnum.unknown);
        }
      },
    );
  });

  group('getPokemonById', () {
    test('return null, if DS return null', () async {
      // Arrange
      when(
        () => mockRemoteDs.getPokemonById(any()),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repo.getPokemonById(1);

      // Assert
      expect(result, null);
    });
  });
}
