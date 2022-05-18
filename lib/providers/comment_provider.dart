import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:qtest/database/database.dart';

import 'package:qtest/http/http_client.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/routes.dart';

class CommentProvider with ChangeNotifier {
  final int _size = 20;

  int _page = 1;

  int get page => _page;

  bool _hasNextPage = true;

  bool get hasNextPage => _hasNextPage;

  bool _firstLoading = false;

  bool get firstLoading => _firstLoading;

  bool _loadMoreRunning = false;

  bool get loadMoreRunning => _loadMoreRunning;

  List<Comment>? _comments;

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

  Future<bool?> searchComments() async {
    setFirstLoading(true);
    var response = await HttpClient.get(
        ApiRoutes.searchComments + '?_page=$page&_limit=$_size');
    if (response != null) {
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<Comment> comments =
            l.map((model) => Comment.fromJson(model)).toList();
        if(comments.isEmpty){
          setNextPage(false);
        }
        _comments = comments;
        await Database().putData(comments);
        setPageCounter();
        setFirstLoading(false);
      }
    } else {
      setNextPage(false);
      final box = await Hive.openBox<Comment>('comments');
      _comments = box.toMap().values.toList();
      _comments?.sort((a, b) => a.id!.compareTo(b.id!));
      setFirstLoading(false);
    }
  }

  Future<bool?> searchMoreComments() async {
    setLoadMoreRunning(true);
    var response = await HttpClient.get(
        ApiRoutes.searchComments + "?_page=$page&_limit=$_size");
    if (response != null) {
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<Comment> comments =
            l.map((model) => Comment.fromJson(model)).toList();
        if(comments.isEmpty){
          setNextPage(false);
        }
        _comments?.addAll(comments);
        await Database().putNewData(comments);
        setPageCounter();
        setLoadMoreRunning(false);
      }
    } else {
      setNextPage(false);
      final box = await Hive.openBox<Comment>('comments');

      _comments = box.toMap().values.toList();
      notifyListeners();

      _comments?.sort((a, b) => a.id!.compareTo(b.id!));
      setLoadMoreRunning(false);
    }
  }
}
