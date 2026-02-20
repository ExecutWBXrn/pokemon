class PokemonEntity {
  final String id;
  final String name;
  final String img;
  final String? bigImg;
  final int? height;
  final int? weight;
  final bool isFavorite;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.img,
    this.bigImg,
    this.height,
    this.weight,
    this.isFavorite = false,
  });

  PokemonEntity copyWith({
    String? id,
    String? name,
    String? img,
    String? bigImg,
    int? height,
    int? weight,
    bool? isFavorite,
  }) {
    return PokemonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      bigImg: bigImg ?? this.bigImg,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
