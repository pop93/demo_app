import 'package:flutter/material.dart';
import 'package:qtest/constants.dart';

class CommentItem extends StatelessWidget {
  final String? leading;
  final String? centerText;
  final Function()? onTap;

  CommentItem({this.leading, this.centerText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => onTap!(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                color: Constants.backgroundGray,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leading ?? "-",
                    style: const TextStyle(
                      color: Constants.mainColor,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      centerText ?? "-",
                      style: const TextStyle(
                        color: Constants.darkGray,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 5,
              color: Constants.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
