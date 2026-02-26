import '../../../../shared/providers/notification_provider.dart';
import '/shared/domain/entities/pokemon_entity.dart';
import '../../domain/repos/pokemon_repo.dart';
import '../../data/repos_impl/pokemon_repo_impl.dart';
import '../../data/datasource/remote/poke_remote_ds.dart';
import '../../data/datasource/remote/poke_remote_ds_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/providers/dio_provider.dart';
import '../../domain/usecases/fetch_all_pokemons_usecase.dart';
import '../../domain/usecases/fetch_pokemon_by_id_usecase.dart';
import '../../domain/usecases/add_to_favorite_and_notify_usecase.dart';
import '../../domain/usecases/remove_from_favorite_and_notify_usecase.dart';
import 'package:pokemon/shared/providers/favorite_pokemon_provider.dart';

final pokemonDataSourceProvider = Provider<PokeRemoteDs>(
  (ref) => PokeRemoteDsImpl(ref.read(dioProvider)),
);

final pokemonRepositoryProvider = Provider<PokemonRepo>(
  (ref) => PokemonRepoImpl(ref.read(pokemonDataSourceProvider)),
);

final fetchAllPokemonsProvider = FutureProvider<List<PokemonEntity>>(
  (ref) => FetchAllPokemonsUseCase(ref.read(pokemonRepositoryProvider))(),
);

final fetchPokemonByIdProvider = FutureProvider.family<PokemonEntity?, int>(
  (ref, id) => FetchPokemonByIdUseCase(ref.read(pokemonRepositoryProvider))(id),
);

final addToFavoriteAndNotifyUseCaseProvider =
    Provider<AddToFavoriteAndNotifyUseCase>(
      (ref) => AddToFavoriteAndNotifyUseCase(
        ref.read(favoriteRepositoryProvider),
        ref.read(notificationServiceProvider),
      ),
    );

final removeFromFavoriteAndNotifyUseCaseProvider =
    Provider<RemoveFromFavoriteAndNotifyUseCase>(
      (ref) => RemoveFromFavoriteAndNotifyUseCase(
        ref.read(favoriteRepositoryProvider),
        ref.read(notificationServiceProvider),
      ),
    );
