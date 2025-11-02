import 'package:hive_flutter/hive_flutter.dart';
part 'pokemon.g.dart';

@HiveType(typeId: 0)
class Pokemon {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String img;
  @HiveField(3)
  final String? bigImg;
  @HiveField(4)
  final int? height;
  @HiveField(5)
  final int? weight;
  @HiveField(6)
  final bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.img,
    this.bigImg,
    this.height,
    this.weight,
    this.isFavorite = false,
  });

  Pokemon copyWith({
    String? id,
    String? name,
    String? img,
    String? bigImg,
    int? height,
    int? weight,
    bool isFavorite = false,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      bigImg: bigImg ?? this.bigImg,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isFavorite: isFavorite,
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'].toString(),
      name: json['name'] as String,
      img: json['sprites']['front_default'] as String,
      bigImg:
          json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
    );
  }

  factory Pokemon.fromJsonById(Map<String, dynamic> json, int id) {
    return Pokemon(
      id: id.toString(),
      name: json['name'].toString().replaceAll("-", " "),
      img:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
    );
  }
}
