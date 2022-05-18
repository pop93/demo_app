import 'package:flutter/foundation.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/repository/localData/comment_repository.dart';

class CommentProvider with ChangeNotifier {

  int _page = 1;

  int get page => _page;

  bool _hasNextPage = true;

  bool get hasNextPage => _hasNextPage;

  bool _firstLoading = false;

  bool get firstLoading => _firstLoading;

  bool _loadMoreRunning = false;

  bool get loadMoreRunning => _loadMoreRunning;

  List<Comment>? _comments = [];

  List<Comment> get commentsList {
    return [...?_comments];
  }

  setNextPage(bool hasNextPage) {
    _hasNextPage = hasNextPage;
    notifyListeners();
  }

  setFirstLoading(bool firstLoading) {
    _firstLoading = firstLoading;
    notifyListeners();
  }

  setLoadMoreRunning(bool loadMoreRunning) {
    _loadMoreRunning = loadMoreRunning;
    notifyListeners();
  }

  setPageCounter() {
    _page += 1;
  }

  Future<bool?> searchComments(isFirstLoading) async {
    List<Comment>? commentsList = [];

    isFirstLoading ? setFirstLoading(true) : setLoadMoreRunning(true);
    commentsList = await CommentRepository().searchComments(page, firstLoading);
    _comments = commentsList;
    setPageCounter();
    isFirstLoading ? setFirstLoading(false) : setLoadMoreRunning(false);
  }
}
