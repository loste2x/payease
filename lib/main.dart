import 'package:flutter/material.dart';
import 'app.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const PayEaseApp());
}
