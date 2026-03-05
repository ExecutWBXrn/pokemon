import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

import '../../../../shared/data/services/notification_service.dart';
import '../../../../shared/domain/repos/favorite_repo.dart';

class AddToFavoriteAndNotifyUseCase {
  final FavoriteRepo _favoriteRepo;
  final NotificationService _notificationService;

  AddToFavoriteAndNotifyUseCase(this._favoriteRepo, this._notificationService);

  Future<void> call(PokemonEntity poke) async {
    await _favoriteRepo.savePokeName(poke);
    _notificationService.showNotification(
      poke.id,
      title: 'Pokemon added to favorites',
      body: poke.name,
    );
  }
}
