import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qtest/ui/comments/providers/comment_provider.dart';

import '../../constants.dart';
import '../common/animations/slide_animation.dart';
import '../common/widgets/comment_item.dart';
import '../common/widgets/reusable_alert_dialog.dart';
import '../common/widgets/reusable_cupertino_alert_dialog.dart';


class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with TickerProviderStateMixin {
  void _loadMore() async {
    var commentProvider = context.read<CommentProvider>();

    if (!commentProvider.firstLoading &&
        !commentProvider.loadMoreRunning &&
        _controller.position.extentAfter < 300) {
      commentProvider.searchComments(false);
    }
  }

  AnimationController? _animationController;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration:
            const Duration(milliseconds: Constants.defaultAnimationDuration));

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<CommentProvider>().searchComments(true);
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
          title: const Text(Constants.appBarText),
        ),
        body: commentProvider.firstLoading
            ? Center(
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commentProvider.commentsList.isEmpty
                      ? const Center(child: Text(Constants.noDataToDisplay))
                      : Expanded(
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
                                        builder: (BuildContext context) {
                                          return ReusableCupertinoDialog(
                                              item: commentProvider
                                                  .commentsList[index]);
                                        })
                                    : () => showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ReusableAlertDialog(
                                                alertItem: commentProvider
                                                    .commentsList[index]);
                                          },
                                        ),
                                leading: commentProvider.commentsList[index].id
                                    .toString(),
                                centerText:
                                    commentProvider.commentsList[index].name,
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
