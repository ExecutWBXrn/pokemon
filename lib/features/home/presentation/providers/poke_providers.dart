import '/core/domain/entities/pokemon_entity.dart';
import '../../domain/repos/pokemon_repo.dart';
import '../../data/repos_impl/pokemon_repo_impl.dart';
import '../../data/datasource/remote/poke_remote_ds.dart';
import '../../data/datasource/remote/poke_remote_ds_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/providers/dio_provider.dart';
import '../../domain/usecases/fetch_all_pokemons_usecase.dart';
import '../../domain/usecases/fetch_pokemon_by_id_usecase.dart';

final pokemonDataSourceProvider = Provider<PokeRemoteDs>(
  (ref) => PokeRemoteDsImpl(ref.read(dioProvider)),
);

final pokemonRepositoryProvider = Provider<PokemonRepo>(
  (ref) => PokemonRepoImpl(ref.read(pokemonDataSourceProvider)),
);

final fetchAllPokemonsProvider = FutureProvider<List<PokemonEntity>>(
  (ref) => FetchAllPokemonsUseCase(ref.read(pokemonRepositoryProvider))(),
);

final fetchPokemonByIdProvider = FutureProvider.family<PokemonEntity?, String>(
  (ref, id) => FetchPokemonByIdUseCase(ref.read(pokemonRepositoryProvider))(id),
);
