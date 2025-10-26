// LIBS

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// SCREENS

import 'package:pokemon/screens/home_screen.dart';
import 'package:pokemon/screens/info_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/info': (context) => InfoPage(),
        },
      ),
    ),
  );
}
