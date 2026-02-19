import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/features/home/presentation/screens/home_screen.dart';
import 'package:pokemon/features/home/presentation/screens/info_screen.dart';
import '/core/data/models/pokemon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>('poke_favorite');

  runApp(ProviderScope(child: MaterialApplication()));
}

class MaterialApplication extends ConsumerWidget {
  const MaterialApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => HomePage(), '/info': (context) => InfoPage()},
    );
  }
}
