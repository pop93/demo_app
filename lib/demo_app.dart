import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qtest/providers/comment_provider.dart';
import 'package:qtest/screens/comments_screen.dart';

import 'constants.dart';

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
                  color: Constants.textColor),
              headline2: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.normal,
                  color: Constants.textColor),
              headline3: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Constants.textColor),
              headline4: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Constants.textColor),
              headline5: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Constants.textColor),
              headline6: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Constants.textColor),
              button: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Constants.textColor),
              bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Constants.textColor,
              ),
              bodyText2: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: Constants.textColor,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const CommentsPage()),
    );
  }
}
