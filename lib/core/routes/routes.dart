import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/info_screen.dart';

final routerProvider = Provider<Map<String, Widget Function(BuildContext)>>(
  (_) => {'/': (context) => HomePage(), '/info': (context) => InfoPage()},
);
