import 'package:flutter/cupertino.dart';
import 'package:qtest/constants.dart';

class ReusableCupertinoDialog extends StatelessWidget {
  const ReusableCupertinoDialog({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(item.email ?? ""),
      content: Text(item.body ?? ""),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text(Constants.alertDialogClose),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
