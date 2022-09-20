import 'package:flutter/material.dart';
import 'package:my_books_app/api/api_book.dart';
import 'package:provider/provider.dart';
import 'pages/page_setting.dart';
import './pages/page_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books Store',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
        routes: {
          SettingPage.nameRoute: (context) => SettingPage(),
        },
      ),
    );
  }
}
