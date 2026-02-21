import 'package:dio/dio.dart';
import 'package:pokemon/shared/data/models/pokemon.dart';
import 'poke_remote_ds.dart';
import 'package:pokemon/shared/data/exceptions/network_exception.dart';
import '../../mappers/dio_exception_to_network_enum_mapper.dart';

class PokeRemoteDsImpl implements PokeRemoteDs {
  final Dio _dioInstance;

  PokeRemoteDsImpl(this._dioInstance);

  @override
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      List<Pokemon> allPokemons = <Pokemon>[];
      final response = await _dioInstance.get(
        '',
        queryParameters: {'offset': 0, 'limit': 1025},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final List pokemons = data['results'];
        for (int i = 0; i < pokemons.length; i++) {
          allPokemons.add(Pokemon.fromJsonById(pokemons[i], i + 1));
        }
      }
      return allPokemons;
    } on DioException catch (e, st) {
      throw NetworkException(DioExceptionToNetworkEnumMapper.map(e));
    }
  }

  @override
  Future<Pokemon?> getPokemonById(String id) async {
    try {
      final response = await _dioInstance.get('/$id');

      Pokemon? pokemon;

      if (response.statusCode == 200) {
        final data = response.data;
        pokemon = Pokemon.fromJson(data);
      }

      return pokemon;
    } on DioException catch (e, st) {
      throw NetworkException(DioExceptionToNetworkEnumMapper.map(e));
    }
  }
}
