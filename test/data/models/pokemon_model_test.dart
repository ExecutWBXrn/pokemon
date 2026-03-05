import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/shared/data/models/pokemon.dart';
import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

void main() {
  group('Pokemon Model Tests', () {
    final mockJson = {
      'id': 25,
      'name': 'pikachu',
      'height': 4,
      'weight': 60,
      'sprites': {
        'front_default': 'https://raw.githubusercontent.com/url_to_img.png',
        'other': {
          'official-artwork': {
            'front_default':
                'https://raw.githubusercontent.com/url_to_big_img.png',
          },
        },
      },
    };

    test('should return a valid model from JSON', () {
      // Act
      final result = Pokemon.fromJson(mockJson);

      // Assert
      expect(result.id, 25);
      expect(result.name, 'pikachu');
      expect(
        result.img,
        contains('https://raw.githubusercontent.com/url_to_img.png'),
      );
      expect(
        result.bigImg,
        contains('https://raw.githubusercontent.com/url_to_big_img.png'),
      );
      expect(result.isFavorite, false);
    });

    test('should correctly convert to Entity', () {
      // Arrange
      final model = Pokemon(id: 1, name: 'Bulbasaur', img: 'url');

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<PokemonEntity>());
      expect(entity.id, model.id);
      expect(entity.name, model.name);
    });

    test('copyWith should return updated isFavorite value', () {
      // Arrange
      final pokemon = Pokemon(
        id: 1,
        name: 'Ditto',
        img: 'url',
        isFavorite: false,
      );

      // Act
      final updated = pokemon.copyWith(isFavorite: true);

      // Assert
      expect(updated.isFavorite, true);
      expect(updated.id, pokemon.id);
    });

    test('fromJsonById should format name correctly (remove hyphens)', () {
      // Arrange
      final json = {'name': 'mr-mime'};

      // Act
      final result = Pokemon.fromJsonById(json, 122);

      // Assert
      expect(result.name, 'mr mime');
      expect(result.id, 122);
    });
  });
}
