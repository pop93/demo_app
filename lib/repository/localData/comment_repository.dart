import 'package:qtest/database/database.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/repository/remoteData/comment_service_api.dart';

import '../../connectivity.dart';

class CommentRepository {
  List<Comment>? commentsList = [];

  Future<List<Comment>?> searchComments(page, clearData) async {
    if (await Connection().check()) {
      commentsList = await CommentService().getComments(page);
      await Database().putData(commentsList, clearData);
    }
    return await Database().fetchDataFromDatabase();
  }
}
