import 'package:flutter/material.dart';


class ImagePlaceHolder extends StatelessWidget {

  void Function()? onTap;

  ImagePlaceHolder({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey
        ),
        child: const Center(
          child: Icon(Icons.camera_alt_outlined,size: 42,),
        ),
      ),
    );
  }
}
