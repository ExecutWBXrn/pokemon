import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';
import 'package:pokemon/features/home/presentation/providers/poke_providers.dart';
import 'package:pokemon/shared/mappers/network_exception_to_message_mapper.dart';

class PokeListScreen extends ConsumerStatefulWidget {
  const PokeListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PokeListScreenState();
  }
}

class _PokeListScreenState extends ConsumerState<PokeListScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<PokemonEntity>> allPokemonList = ref.watch(
      fetchAllPokemonsProvider,
    );

    return Center(
      child: allPokemonList.when(
        data: (data) {
          return ListView.builder(
            itemCount: allPokemonList.value?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  child: Hero(
                    tag: 'avatar-${allPokemonList.value![index].id}-plist',
                    child: Image.network(
                      fit: BoxFit.fill,
                      allPokemonList.value![index].img,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported_outlined);
                      },
                    ),
                  ),
                ),
                title: Text(
                  allPokemonList.value![index].name.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/info',
                    arguments: <String, String>{
                      'pokeId': allPokemonList.value![index].id,
                      'pageFrom': 'plist',
                    },
                  );
                },
              );
            },
          );
        },
        error: (error, stack) {
          return Text(NetworkExceptionToMessageMapper.map(error));
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
