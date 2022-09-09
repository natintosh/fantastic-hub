import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hub/__core__/dependency_injector.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();

  runApp(await builder());
}
