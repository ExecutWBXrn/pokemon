import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

import '../../../../shared/data/services/notification_service.dart';
import '../../../../shared/domain/repos/favorite_repo.dart';

class RemoveFromFavoriteAndNotifyUseCase {
  final FavoriteRepo _favoriteRepo;
  final NotificationService _notificationService;

  RemoveFromFavoriteAndNotifyUseCase(
    this._favoriteRepo,
    this._notificationService,
  );

  Future<void> call(PokemonEntity poke) async {
    await _favoriteRepo.deletePokeName(poke);
    _notificationService.showNotification(
      poke.id,
      title: 'Pokemon removed from favorites',
      body: poke.name,
    );
  }
}
