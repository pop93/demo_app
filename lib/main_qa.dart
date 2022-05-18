import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/env.dart';
import 'database/database.dart';
import 'main.dart';
import 'models/comment.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Database().openBox();
  runApp(const QTest());

  BuildEnvironment.init(
      flavor: BuildFlavor.staging, baseUrl: 'https://dev.example.com');
  assert(env != null);
  runApp(const QTest());
}
