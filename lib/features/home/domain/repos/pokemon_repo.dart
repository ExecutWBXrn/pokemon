import 'package:pokemon/core/domain/entities/pokemon_entity.dart';

import '/core/data/models/pokemon.dart';

abstract class PokemonRepo {
  Future<List<PokemonEntity>> getAllPokemons();
  Future<PokemonEntity?> getPokemonById(String id);
}
