import 'package:qtest/database/database.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/repository/remoteData/comment_service_api.dart';

import '../../connectivity.dart';

class CommentRepository {
  final CommentService _commentService = CommentService();
  final Database _database = Database();
  final Connection _connection = Connection();

  List<Comment>? commentsList = [];
  int page = 1;

  Future<List<Comment>?> searchComments(clearData) async {
    if (await _connection.check()) {
      commentsList = await _commentService.getComments(page);
      await _database.putData(commentsList, clearData);
      if (commentsList != null) {
        if (commentsList!.isNotEmpty) {
          setPage();
        }
      }
    }
    return await _database.fetchDataFromDatabase();
  }

  setPage() {
    page += 1;
  }
}
