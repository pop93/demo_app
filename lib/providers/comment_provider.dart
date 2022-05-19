import 'package:flutter/foundation.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/repository/comment_repository.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepository _commentRepository = CommentRepository();

  bool _firstLoading = false;

  bool get firstLoading => _firstLoading;

  bool _loadMoreRunning = false;

  bool get loadMoreRunning => _loadMoreRunning;

  List<Comment>? _comments = [];

  List<Comment> get commentsList {
    return [...?_comments];
  }

  setFirstLoading(bool firstLoading) {
    _firstLoading = firstLoading;
    notifyListeners();
  }

  setLoadMoreRunning(bool loadMoreRunning) {
    _loadMoreRunning = loadMoreRunning;
    notifyListeners();
  }

  Future<bool?> searchComments(isFirstLoading) async {
    List<Comment>? commentsList = [];

    isFirstLoading ? setFirstLoading(true) : setLoadMoreRunning(true);
    commentsList = await _commentRepository.searchComments(firstLoading);
    _comments = commentsList;
    isFirstLoading ? setFirstLoading(false) : setLoadMoreRunning(false);
  }
}
