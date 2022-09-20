import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const nameRoute = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Created By Arfi Zulfiansyah",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "With Flutter 3.0 \n Supported by Edspert",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Text(
              "copyright@2022",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
