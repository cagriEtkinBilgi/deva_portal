import 'package:deva_portal/models/component_models/address_dropdown_component_result_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:flutter/material.dart';
import '../build_progress_widget.dart';
import '../dropdown_serach_widget.dart';

class AddressDistrictDropdownComponent extends StatefulWidget {


  List<DropdownSearchModel>? districtes;
  List<DropdownSearchModel>? neighborhoodes;

  Future<List<DropdownSearchModel>> Function(int DistrictId)? getNeighborhood;
  AddressDropdownComponentResultModel result= AddressDropdownComponentResultModel();
  Function? onChange;
  ///0 görünmüyor 1 loading 2 result geldi 3 hata!!!

  int showNeighborhood=0;
   AddressDistrictDropdownComponent({
     Key? key,
     this.districtes,
     this.getNeighborhood,
     this.onChange
   }) : super(key: key);

  @override
  _AddressDistrictDropdownComponentState createState() => _AddressDistrictDropdownComponentState();
}

class _AddressDistrictDropdownComponentState extends State<AddressDistrictDropdownComponent> {

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
            DropdownSerachWidget(
              items: widget.districtes!,
              dropdownLabel: "İlçe",
              //defauld value bakılacak
              onChange: (val){
                widget.result.districtId=val.id;
                setState(() {
                  widget.showNeighborhood=1;
                });
                widget.getNeighborhood!(val.id).then((value) =>{
                  if(value.length>0){
                    widget.neighborhoodes=value,
                    setState(() {
                      widget.showNeighborhood=2;
                    })
                  }else{
                    setState(() {
                      widget.showNeighborhood=0;
                    })
                  }

                });
                widget.onChange!(widget.result);

              },
            ),
            buildNeighborhood(),
          ],
        ),
      );
  }



  Widget buildNeighborhood() {
    if(widget.showNeighborhood==1)
      return Center(child: ProgressWidget());
    else if(widget.showNeighborhood==2) {
      return Container(
        child: DropdownSerachWidget(
          items: widget.neighborhoodes!,
          dropdownLabel: "Mahalle",
          onChange: (val){
            widget.result.neighborhoodId=val.id;
            widget.onChange!(widget.result);
          },
        ),
      );
    } else
      return Container();
  }

}


