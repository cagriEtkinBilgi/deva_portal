import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_portal/models/component_models/image_select_component_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../image_placeholder.dart';

class ImageSelectComponents extends StatefulWidget {
  String? url;
  Function? onChange;
  ImageSelectComponents({
    this.url,
    this.onChange
  });
  @override
  _ImageSelectComponentsState createState() => _ImageSelectComponentsState();
}

class _ImageSelectComponentsState extends State<ImageSelectComponents> {
  var picker;
  var resultModel;
  @override
  void initState() {
    picker = ImagePicker();
    resultModel=ImageSelectComponentModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children:[
        buildImage(),
        Positioned(
          bottom: 0,
          right: 0,
          child: buildFileIconButton()
        )
      ]
      ),
    );
  }


  Widget buildImage(){
    if(resultModel.file!=null){
      return Ink.image(
        image: FileImage(resultModel.file),
        fit:BoxFit.cover,
        width: 140,
        height: 140,
        child: InkWell(
          onTap: () async {
            await imagePicker(ImageSource.camera);
          },
        ),

      );

    }else if(resultModel.file==null && widget.url==null||widget.url==""){
      return ImagePlaceHolder(
        onTap: () async {
          await imagePicker(ImageSource.camera);
        },
      );
    }else{
      return InkWell(
        onTap: () async {
          await imagePicker(ImageSource.camera);
        },
        child: Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50)
            ),
            child: CachedNetworkImage(
              imageUrl: AppTools.apiUri+ widget.url!,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      );
    }

  }

  Future imagePicker(ImageSource source) async {
    var imageResuld=await picker.getImage(source:source );
    if(imageResuld!=null){
      setState(() {
        resultModel.file = File(imageResuld.path);
        resultModel.url=imageResuld.path;
        resultModel.fileName=imageResuld.path.split('/').last;
      });
      widget.onChange!(resultModel);
    }
  }

  Widget buildFileIconButton(){
   return Container(
     padding: EdgeInsets.all(4),
     decoration: const BoxDecoration(
       shape: BoxShape.circle,
       color: Colors.lightBlue
     ),
     child: InkWell(
       onTap: () async{
         await imagePicker(ImageSource.gallery);
       },
       child: const Icon(
         Icons.folder,
         size: 30,
         color: Colors.white,
       ),

     ),
   );
  }
}
