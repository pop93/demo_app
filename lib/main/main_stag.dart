import 'package:flutter/material.dart';
import 'package:qtest/config/env.dart';
import 'package:qtest/utils/main_init.dart';
import 'package:qtest/demo_app.dart';
import 'package:qtest/routes.dart';

void main() async {
  await MainInit.init();

  FlavorConfig(
      flavor: BuildFlavor.development,
      flavorValue: FlavorValue(baseUrl: ApiRoutes.stagBaseUrl));
  runApp(const QTest());
}
