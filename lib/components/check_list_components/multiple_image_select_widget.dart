import 'dart:io';
import 'package:deva_portal/models/component_models/attachment_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageSelectWidget extends StatefulWidget {
  Function? onChange;
  List<AttachmentDialogModel>? images=[];
  MultipleImageSelectWidget({this.onChange,this.images});

  @override
  _MultipleImageSelectWidgetState createState() => _MultipleImageSelectWidgetState();
}

class _MultipleImageSelectWidgetState extends State<MultipleImageSelectWidget> {

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height-235,
      child: GridView.builder(
        itemCount: widget.images!.length+1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (ctx,i){
          return _buildGridItem(i);
        }
      ),
    );
  }

  Widget _buildGridItem(int i) {
    if(i==widget.images!.length){
      return _buildAddButton();
    }
    return gridTile(widget.images![i]);
  }

  Widget gridTile(AttachmentDialogModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.transparent,
            leading: PopupMenuButton<String>(
              onSelected: (e){
                setState(() {
                  widget.images!.remove(model);
                  widget.onChange!(widget.images);
                });

              },
              itemBuilder: (_)=>[
                const PopupMenuItem(
                  child: Text("Sil"),
                  value: "1",
                ),
              ],
            ),
          ),
          child: Image.file(model.file!)
        ),
      ),
    );
  }

  GridTile _buildAddButton() {
    return GridTile(
      child: Card(
        child: Stack(
          children: [
            Center(
              child: IconButton(
                icon: const Icon(Icons.photo_camera),
                iconSize: 60,
                onPressed: (){
                  pickImage(ImageSource.camera);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: (){
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.drive_file_move)
              ),
            ),
          ],
        ),
      )
    );
  }

  Future pickImage(ImageSource source) async {//dosya seçme işlemeleri yapılacak ve buttonlara eklenecek
    var result = await picker.pickImage(source: source);
    if(result!=null){
        var model=AttachmentDialogModel();
        model.name=result.path.split('/').last;
        model.file=File(result.path);
        model.filePath=result.path;
        setState((){
          widget.images!.add(model);
        });
    }
    widget.onChange!(widget.images);
  }


}
