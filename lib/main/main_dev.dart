import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qtest/routes.dart';
import 'package:qtest/config/env.dart';
import 'package:qtest/database/database.dart';
import 'package:qtest/demo_app.dart';
import 'package:qtest/models/comment.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Database().openBox();

  FlavorConfig(
      flavor: BuildFlavor.development,
      color: Colors.deepPurpleAccent,
      flavorValue: FlavorValue(baseUrl: ApiRoutes.devBaseUrl));
  runApp(const QTest());
}
