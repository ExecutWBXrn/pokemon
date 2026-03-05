import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/core/routes/routes.dart';
import 'package:pokemon/shared/providers/notification_provider.dart';
import '/shared/data/models/pokemon.dart';
import 'package:pokemon/shared/data/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>('poke_favorite');

  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: MaterialApplication(),
    ),
  );
}

class MaterialApplication extends ConsumerWidget {
  const MaterialApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(initialRoute: '/', routes: ref.read(routerProvider));
  }
}
