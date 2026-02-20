// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as String,
      name: fields[1] as String,
      img: fields[2] as String,
      bigImg: fields[3] as String?,
      height: fields[4] as int?,
      weight: fields[5] as int?,
      isFavorite: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.bigImg)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
