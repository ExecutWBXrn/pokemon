import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../data/models/pokemon.dart';

final boxProvider = Provider<Box<Pokemon>>(
  (ref) => Hive.box<Pokemon>('poke_favorite'),
);
