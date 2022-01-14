import 'package:flutter/material.dart';

class DetailCardWidget extends StatelessWidget {
  String? title;
  String? desc;
  String? footer;

  DetailCardWidget({this.title,this.desc,this.footer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(title??"",style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(desc??"",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(footer??"",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
