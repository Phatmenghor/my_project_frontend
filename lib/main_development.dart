import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_project/core/services/dependency_injection.dart';
import 'package:my_project/main.dart';

void main() async {
  await dotenv.load(fileName: "assets/env/.env.development");
  setupDependencyInjection();

  runApp(const MyApp());
}
