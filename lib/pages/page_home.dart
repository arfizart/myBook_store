import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/page_setting.dart';
import '../views/datalist_book.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("myBook\'s Colections"),
            Icon(Icons.library_books),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.green,
              alignment: Alignment.bottomLeft,
              child: Text(
                "Main Menu",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.home,
                size: 35,
              ),
              title: Text("Home"),
            ),
            ListTile(
              onTap: (() {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(SettingPage.nameRoute);
              }),
              leading: Icon(
                Icons.info,
                size: 35,
              ),
              title: Text("About"),
            ),
          ],
        ),
      ),
      body: BookListPage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Uri uri = Uri.parse("https://facebook.com/ddterakhir");
          try {
            await canLaunchUrl(uri) ? launchUrl(uri) : print("Link Invalid");
          } catch (e) {
            print(e);
          }
        },
        label: const Text('Like us'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
