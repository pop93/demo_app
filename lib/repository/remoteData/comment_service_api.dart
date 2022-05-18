import 'dart:convert';
import 'package:qtest/http/http_client.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/routes.dart';

class CommentService {
  final int _size = 20;

  Future<List<Comment>?> getComments(int page) async {
    var response = await HttpClient.get(
        ApiRoutes.searchComments + '?_page=$page&_limit=$_size');
    if (response != null) {
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<Comment> comments =
            l.map((model) => Comment.fromJson(model)).toList();

        return comments;
      } else {
        return [];
      }
    }
  }
}
