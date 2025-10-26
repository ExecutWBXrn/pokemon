class Pokemon {
  final String id;
  final String name;
  final String img;
  final String? bigImg;
  final int? height;
  final int? weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.img,
    this.bigImg,
    this.height,
    this.weight,
  });

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
