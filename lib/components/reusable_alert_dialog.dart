import 'package:flutter/material.dart';
import 'package:qtest/constants.dart';

class ReusableAlertDialog extends StatelessWidget {
  const ReusableAlertDialog({
    Key? key,
    required this.alertItem,
  }) : super(key: key);

  final dynamic alertItem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertItem.email ?? ""),
      content: Text(alertItem.body ?? ""),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(Constants.alertDialogClose))
      ],
    );
  }
}
