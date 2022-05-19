import 'package:qtest/source_local/database.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/source_remote/comment_service_api.dart';

import '../utils/connectivity.dart';

class CommentRepository {
  final CommentService _commentService = CommentService();
  final Database _database = Database();
  final Connection _connection = Connection();

  List<Comment>? commentsList = [];
  int page = 1;

  Future<List<Comment>?> searchComments(clearData) async {
    if (await _connection.check()) {
      commentsList = await _commentService.getComments(page);
      if (commentsList != null && commentsList!.isNotEmpty) {
        await _database.putData(commentsList, clearData);
        incrementCurrentPage();
      }
    }
    return await _database.fetchDataFromDatabase();
  }

  incrementCurrentPage() {
    page += 1;
  }
}
