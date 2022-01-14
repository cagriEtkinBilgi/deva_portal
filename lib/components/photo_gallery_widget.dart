import 'package:deva_portal/models/component_models/photo_gallery_model.dart';
import 'package:deva_portal/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryWidget extends StatefulWidget {

  List<PhotoGalleryModel>? images;
  int initIndex=1;

  PhotoGalleryWidget({
    this.images,
    this.initIndex=0
  }): pageController = PageController(initialPage: initIndex);
  final PageController pageController;
  @override
  _PhotoGalleryWidgetState createState() => _PhotoGalleryWidgetState();
}

class _PhotoGalleryWidgetState extends State<PhotoGalleryWidget> {

  int currentIndex=0;
  String title="";
  @override
  void initState() {
    currentIndex= widget.initIndex;
    title=widget.images![currentIndex].imageName!;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.images!.length,
              loadingBuilder: _loadingBuilder,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: widget.pageController,
              onPageChanged: onPageChanged,

            ),

          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    var item = widget.images![index];
    title=item.imageName!;
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
        AppTools.apiUri+item.imageUrl!,
      ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id??0),
    );
  }


  Widget _loadingBuilder(BuildContext context, ImageChunkEvent? event) {
    return Center(
      child: Container(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: event == null
              ? 0
              : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
        ),
      ),
    );
  }
}
