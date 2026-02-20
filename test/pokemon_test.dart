import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/shared/data/models/pokemon.dart';

void main() {
  test('Pokemon fromJson should correctly parse a map', () {
    final Map<String, dynamic> jsonMap = {
      'id': 25,
      'name': 'pickachu',
      'height': 4,
      'weight': 60,
      'sprites': {
        'front_default': 'https://pokeapi.co/pikachu.png',
        'other': {
          'official-artwork': {
            'front_default': 'https://pokeapi.co/pikachu_big.png',
          },
        },
      },
    };

    final pokemon = Pokemon.fromJson(jsonMap);

    expect(pokemon.id, '25');
    expect(pokemon.name, 'pickachu');
    expect(pokemon.height, 4);
    expect(pokemon.weight, 60);
    expect(pokemon.img, 'https://pokeapi.co/pikachu.png');
    expect(pokemon.bigImg, 'https://pokeapi.co/pikachu_big.png');
  });

  test('Pokemon fromJson should handle missing optional fields', () {
    final Map<String, dynamic> jsonMap = {
      'id': 1,
      'name': 'bulbasaur',
      'sprites': {
        'front_default': 'https://pokeapi.co/pikachu.png',
        'other': {'official-artwork': {}},
      },
    };

    final pokemon = Pokemon.fromJson(jsonMap);

    expect(pokemon.id, '1');
    expect(pokemon.name, 'bulbasaur');
    expect(pokemon.height, isNull);
    expect(pokemon.weight, isNull);
    expect(pokemon.img, 'https://pokeapi.co/pikachu.png');
    expect(pokemon.bigImg, 'https://pokeapi.co/pikachu.png');
  });
}
