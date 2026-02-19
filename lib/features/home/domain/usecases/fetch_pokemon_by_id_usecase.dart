import '/core/domain/entities/pokemon_entity.dart';
import '../repos/pokemon_repo.dart';

class FetchPokemonByIdUseCase {
  final PokemonRepo _repo;
  FetchPokemonByIdUseCase(this._repo);

  Future<PokemonEntity?> call(String id) async {
    return await _repo.getPokemonById(id);
  }
}
