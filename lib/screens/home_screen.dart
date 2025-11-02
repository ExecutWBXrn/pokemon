// libs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// BLOGIC

import 'package:pokemon/blogic/bottom_nav_provider.dart';

// pages

import 'package:pokemon/screens/poke_list_screen.dart';
import 'package:pokemon/screens/favorite_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final BottomIndex bottomIndexState = ref.watch(bottomIndexProvider);

    final BottomIndexNotifier bottomIndex = ref.watch(
      bottomIndexProvider.notifier,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          "Pokemon",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.yellow,
            shadows: [Shadow(color: Colors.blue, blurRadius: 25)],
          ),
        ),
      ),
      body: IndexedStack(
        index: bottomIndexState.index,
        children: [PokeListScreen(), FavoritePokemons()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.yellow,
        selectedIconTheme: IconThemeData(
          size: 30,
          shadows: [Shadow(color: Colors.blue, blurRadius: 25)],
        ),
        currentIndex: bottomIndexState.index,
        onTap: bottomIndex.setIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Pokemons",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
