// libs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// BLOGIC

import 'package:pokemon/blogic/pokemon.dart';
import 'package:pokemon/blogic/pokemon_provider.dart';

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

    if (pokeId == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Помилка")),
        body: const Center(child: Text("ID покемона не було передано.")),
      );
    }

    final AsyncValue<Pokemon?> pokemonAsync = ref.watch(
      pokemonProvider(pokeId),
    );

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
        child: pokemonAsync.when(
          data: (data) {
            if (data == null) {
              return Center(
                child: Text("Не вдалося завантажити дані про покемона"),
              );
            }
            return Column(
              children: [
                Hero(
                  tag: 'avatar-$pokeId',
                  child: Image.network(
                    data.bigImg ?? data.img,
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
                          "Name: ${data.name.toUpperCase()}",
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Height: ${data.height}0 cm",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Weight: ${data.weight! / 10} kg",
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
