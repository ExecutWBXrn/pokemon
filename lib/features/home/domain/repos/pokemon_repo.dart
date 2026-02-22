import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

import '/shared/data/models/pokemon.dart';

abstract class PokemonRepo {
  Future<List<PokemonEntity>> getAllPokemons();
  Future<PokemonEntity?> getPokemonById(int id);
}
