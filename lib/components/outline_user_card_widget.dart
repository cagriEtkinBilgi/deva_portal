import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';


class OutlineUserCardWidget extends StatelessWidget {
  String nameSurname;
  String footer;
  String url;

  OutlineUserCardWidget({this.nameSurname="",this.footer="",this.url=""});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  child: avatarBuilder(url)
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(nameSurname),
                  Text(footer)
                ],
              ),
            ),

          ],

        ),
      ),
    );
  }

  Widget avatarBuilder(String Uri) {
    if(Uri!=null){
      return CachedNetworkImage(
        fit: BoxFit.fitHeight,
        imageUrl: AppTools.apiUri+Uri,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.error_outline,
          size: 50,
        ),
      );
    }else{
      return const Icon(
        Icons.account_circle,
        size: 100,
      );
    }


  }
}
