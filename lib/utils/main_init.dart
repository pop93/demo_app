import 'package:hive_flutter/hive_flutter.dart';
import 'package:qtest/source_local/database.dart';

import '../models/comment.dart';

class MainInit {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CommentAdapter());
    await Database().openBox();
  }
}
