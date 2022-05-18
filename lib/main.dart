import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qtest/models/comment.dart';
import 'package:qtest/providers/comment_provider.dart';
import 'package:qtest/screens/comments_screen.dart';
import 'constants/app_colors.dart';
import 'database/database.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Database().openBox();
  runApp(const QTest());
}

class QTest extends StatelessWidget {
  final String appTitle = 'Comments';

  const QTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: MaterialApp(
          title: appTitle,
          theme: ThemeData(
            primarySwatch: Colors.green,
            backgroundColor: Colors.white,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textColor),
              headline2: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
              headline3: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
              headline4: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
              headline5: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
              headline6: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textColor),
              button: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
              bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
              bodyText2: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const CommentsPage()),
    );
  }
}

