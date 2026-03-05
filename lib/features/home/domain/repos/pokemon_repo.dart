import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

abstract class PokemonRepo {
  Future<List<PokemonEntity>> getAllPokemons();
  Future<PokemonEntity?> getPokemonById(int id);
}
