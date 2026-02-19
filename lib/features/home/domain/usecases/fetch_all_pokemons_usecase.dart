import '/core/data/models/pokemon.dart';
import '/core/domain/entities/pokemon_entity.dart';
import '../repos/pokemon_repo.dart';

class FetchAllPokemonsUseCase {
  final PokemonRepo _repo;
  FetchAllPokemonsUseCase(this._repo);

  Future<List<PokemonEntity>> call() async {
    return await _repo.getAllPokemons();
  }
}
