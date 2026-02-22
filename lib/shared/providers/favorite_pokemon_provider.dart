import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasource/local/favorite_hive_local_ds.dart';
import '../data/datasource/local/favorite_hive_local_ds_impl.dart';
import '/shared/domain/entities/pokemon_entity.dart';
import '/shared/domain/repos/favorite_repo.dart';
import '/shared/data/repos_impl/favorite_repo_impl.dart';
import './box_provider.dart';
import 'notification_provider.dart';

final favoriteHiveDataSourceProvider = Provider<FavoriteHiveLocalDs>(
  (ref) => FavoriteHiveLocalDsImpl(
    ref.read(boxProvider),
    ref.read(notificationServiceProvider),
  ),
);

final favoriteRepositoryProvider = Provider<FavoriteRepo>(
  (ref) => FavoriteRepoImpl(ref.read(favoriteHiveDataSourceProvider)),
);

final favoritePokeProvider = FutureProvider.family<PokemonEntity?, int>((
  ref,
  id,
) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.getPokeName(id);
});

final favoritesStreamProvider = StreamProvider.autoDispose<List<PokemonEntity>>(
  (ref) {
    final repository = ref.watch(favoriteRepositoryProvider);

    final controller = StreamController<List<PokemonEntity>>();

    final initialData = repository.getInitialFavorites();
    controller.add(initialData);

    final subscription = repository.watchPokemon().listen((updatedList) {
      if (!controller.isClosed) {
        controller.add(updatedList);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
