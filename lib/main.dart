// LIBS

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// SCREENS

import 'package:pokemon/screens/home_screen.dart';
import 'package:pokemon/screens/info_screen.dart';

// blogic

import 'package:pokemon/blogic/pokemon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<Pokemon>('poke_favorite');

  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/info': (context) => InfoPage(),
        },
      ),
    ),
  );
}
