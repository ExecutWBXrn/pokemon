// libs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// BLOGIC

import 'package:pokemon/blogic/pokemon.dart';
import 'package:pokemon/blogic/pokemon_provider.dart';
import 'package:pokemon/blogic/favorite_pokemon_provider.dart';

class InfoPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(title: Text("Помилка")),
        body: const Center(
          child: Text('Неправильні дані для екрану інформації.'),
        ),
      );
    }

    final String? pokeId = args['pokeId'];
    final String? pageFrom = args['pageFrom'];

    if (pokeId == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Помилка")),
        body: const Center(child: Text("ID покемона не було передано.")),
      );
    }

    ref.listen(pokemonProvider(pokeId), (previous, next) {
      if (next is AsyncError && (previous is! AsyncError)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Помилка завантаження'),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (next is AsyncData && next.value == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Not found'),
            content: const Text('Такого покемона не існує'),
          ),
        );
      }
    });

    final AsyncValue<Pokemon?> AsyncHivePokemon = ref.watch(
      favoritePokeProvider(pokeId),
    );

    final favoriteNotifier = ref.read(favoriteRepositoryProvider);

    return Scaffold(
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
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: AsyncHivePokemon.when(
          data: (data) {
            if (data == null) {
              final AsyncValue<Pokemon?> pokemonAsync = ref.watch(
                pokemonProvider(pokeId),
              );
              pokemonAsync.when(
                data: (dataFetched) {
                  print("Data fetched");
                  if (dataFetched == null) {
                    return Center(
                      child: Text("Не вдалось завантажити дані про покемона"),
                    );
                  }
                  data = dataFetched;
                },
                error: (e, s) {
                  print("Error fetching data");
                },
                loading: () {
                  print("Trying to fetch data from API");
                },
              );
            }

            if (data == null) {
              return CircularProgressIndicator();
            }

            return Column(
              children: [
                Hero(
                  tag: 'avatar-$pokeId-$pageFrom',
                  child: Image.network(
                    data!.bigImg ?? data!.img,
                    loadingBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            width: 300,
                            height: 350,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        size: 300,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: BoxBorder.all(color: Colors.white, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Name: ${data!.name.toUpperCase()}",
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (data!.isFavorite) {
                                  favoriteNotifier.deletePokeName(data!.id);
                                } else {
                                  favoriteNotifier.savePokeName(
                                    data!.copyWith(isFavorite: true),
                                  );
                                }
                                ref.refresh(favoritePokeProvider(data!.id));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        data!.isFavorite
                                            ? "${data!.name} removed from favorite!"
                                            : "${data!.name} added to favorite!",
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: const Duration(
                                        milliseconds: 800,
                                      ),
                                    ),
                                    snackBarAnimationStyle: AnimationStyle(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                data!.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 40,
                                color: data!.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Height: ${data!.height}0 cm",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Weight: ${data!.weight! / 10} kg",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, s) {
            print("Error: $error, $s");
            return const Text("Some error occurred");
          },
          loading: () {
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
