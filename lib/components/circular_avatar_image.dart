import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';

class CircularAvatarComponent extends StatelessWidget {
   CircularAvatarComponent({
    Key? key,
    this.height=80.0,
    this.width=80.0,
    this.shape=BoxShape.circle,
    required this.Uri,
  }) : super(key: key);

  String Uri;
  double width;
  double height;
  BoxShape shape;

  @override
  Widget build(BuildContext context) {
    if(Uri!=null){
      return CachedNetworkImage(
        imageUrl: AppTools.apiUri+ Uri,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context,imageProvider)=>Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: shape,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.contain),
          ),
        ),
      );
    }else{
      return Icon(Icons.account_box_outlined);
    }


  }
}