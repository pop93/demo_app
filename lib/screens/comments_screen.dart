import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qtest/components/comment_item.dart';
import 'package:qtest/providers/comment_provider.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {


  void _loadMore() async {
    var commentProvider = context.read<CommentProvider>();

    if (commentProvider.hasNextPage &&
        !commentProvider.firstLoading &&
        !commentProvider.loadMoreRunning &&
        _controller.position.extentAfter < 300) {
      commentProvider.searchMoreComments();
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<CommentProvider>().searchComments();
    });
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommentProvider commentProvider = Provider.of<CommentProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
        ),
        body: commentProvider.firstLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: commentProvider.commentsList.length,
                      itemBuilder: (_, index) => CommentItem(
                        onTap: Platform.isIOS
                            ? () =>
                            showCupertinoDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    title: Text(commentProvider
                                            .commentsList[index].email ??
                                        ""),
                                    content: Text(commentProvider
                                            .commentsList[index].body ??
                                        ""),
                                    actions: <CupertinoDialogAction>[
                                      CupertinoDialogAction(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                            : () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(commentProvider
                                            .commentsList[index].email ??
                                        ""),
                                    content: Text(commentProvider
                                            .commentsList[index].body ??
                                        ""),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Go Back'))
                                    ],
                                  ),
                                ),
                        input1:
                            commentProvider.commentsList[index].id.toString(),
                        input2: commentProvider.commentsList[index].name,
                      ),
                    ),
                  ),
                  if (commentProvider.loadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: Platform.isIOS
                            ? const CupertinoActivityIndicator()
                            : const CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: _scrollUp,
          child: const Icon(Icons.arrow_upward),
        ));
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
