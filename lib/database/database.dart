import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qtest/models/comment.dart';

class Database {
  Box<Comment>? box;

  Future putData(firstComments, clearData) async {
    box = await Hive.openBox<Comment>('comments');
    await clearData
        ? clearDataFromDatabase().then(
            (value) => firstComments.forEach((comment) => {box?.add(comment)}))
        : firstComments.forEach((comment) => {box?.add(comment)});
  }

  Future<List<Comment>?> fetchDataFromDatabase() async {
    box = await Hive.openBox<Comment>('comments');
    return box?.toMap().values.toList();
  }

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future<void> clearDataFromDatabase() async {
    await box?.clear();
  }
}
