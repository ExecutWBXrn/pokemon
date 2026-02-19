import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/features/home/presentation/screens/poke_list_screen.dart';
import 'package:pokemon/features/favorite/presentation/screens/favorite_screen.dart';
import '../providers/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final int bottomIndexValue = ref.watch(bottomIndexProvider);

    final bottomIndexState = ref.read(bottomIndexProvider.notifier);

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
        index: bottomIndexValue,
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
        currentIndex: bottomIndexValue,
        onTap: (index) {
          bottomIndexState.state = index;
        },
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
