import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qtest/animations/slide_animation.dart';
import 'package:qtest/components/comment_item.dart';
import 'package:qtest/providers/comment_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with TickerProviderStateMixin {

  void _loadMore() async {
    var commentProvider = context.read<CommentProvider>();

    if (commentProvider.hasNextPage &&
        !commentProvider.firstLoading &&
        !commentProvider.loadMoreRunning &&
        _controller.position.extentAfter < 300) {
      commentProvider.searchMoreComments();
    }
  }

  AnimationController? _animationController;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: Constants.animationDuration));

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<CommentProvider>().searchComments();
    });
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommentProvider commentProvider = Provider.of<CommentProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                      itemBuilder: (_, index) => SlideAnimation(
                        itemCount: commentProvider.commentsList.length,
                        position: index,
                        slideDirection: SlideDirection.fromLeft,
                        animationController: _animationController!,
                        child: CommentItem(
                          onTap: Platform.isIOS
                              ? () => showCupertinoDialog<void>(
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
                                            child: const Text('Close'))
                                      ],
                                    ),
                                  ),
                          input1:
                              commentProvider.commentsList[index].id.toString(),
                          input2: commentProvider.commentsList[index].name,
                        ),
                      ),
                    ),
                  ),
                  if (commentProvider.loadMoreRunning)
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
