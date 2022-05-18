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
  runApp(const QTest());

  BuildEnvironment.init(
      flavor: BuildFlavor.development, baseUrl: ApiRoutes.baseUrl);
  assert(env != null);
  runApp(const QTest());
}
