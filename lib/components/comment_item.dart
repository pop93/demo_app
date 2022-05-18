import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CommentItem extends StatelessWidget {
  final String? input1;
  final String? input2;
  final String? resource;
  final Function()? onTap;

  CommentItem({this.input1, this.input2, this.resource,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => onTap!() ,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                color: AppColors.backgroundGray,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    input1 ?? "-" ,
                    style: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      input2 ?? "-",
                      style: const TextStyle(
                        color: AppColors.darkGray,
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
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
