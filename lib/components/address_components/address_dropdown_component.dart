import 'package:deva_portal/models/component_models/address_dropdown_component_result_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:flutter/material.dart';
import '../build_progress_widget.dart';
import '../dropdown_serach_widget.dart';
class AddressDropdownComponent extends StatefulWidget {
  List<DropdownSearchModel>? providences;
  List<DropdownSearchModel>? districtes;
  List<DropdownSearchModel>? neighborhoodes;
  Future<List<DropdownSearchModel>> Function(int providenceId)? getDistrict;
  Future<List<DropdownSearchModel>> Function(int DistrictId)? getNeighborhood;
  AddressDropdownComponentResultModel? result;
  Function? onChange;
  ///0 görünmüyor 1 loading 2 result geldi 3 hata!!!
  int showDistrict=0;
  int showNeighborhood=0;
  AddressDropdownComponent({
    this.providences,
    this.getDistrict,
    this.getNeighborhood,
    this.onChange
  });

  @override
  _AddressDropdownComponentState createState() => _AddressDropdownComponentState();
}

class _AddressDropdownComponentState extends State<AddressDropdownComponent> {

  late List<DropdownSearchModel> districts;
  @override
  void initState() {
    widget.result=AddressDropdownComponentResultModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSerachWidget(
          items: widget.providences!,
          dropdownLabel: "İl",
          onChange: (val){
            widget.result!.providenceId=val.id;
            setState(() {
              widget.showDistrict=1;
            });
            widget.getDistrict!(val.id).then((value) => {
              if(value.length>0){
                widget.districtes=value,
                widget.showDistrict=2,
                setState(() {
                })
              }else{
                widget.showDistrict=0,
                setState(() {
                })
              }
            });
            widget.onChange!(widget.result);
          },
        ),
        Visibility(
          visible: widget.showDistrict!=0,
          child:buildDistrict(),
        ),
        Visibility(
          visible: widget.showNeighborhood!=0,
          child:buildNeighborhood(),
        ),
      ],
    );
  }

  Widget buildDistrict() {
    if(widget.showDistrict==1) {
      return Center(child: ProgressWidget());
    } else if(widget.showDistrict==2) {
      return Container(
        child: DropdownSerachWidget(
          items: widget.districtes??[],
          dropdownLabel: "İlçe",
          onChange: (val){
            widget.result!.districtId=val.id;
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
      );
    } else {
      return Container();
    }

  }

  Widget buildNeighborhood() {
    if(widget.showNeighborhood==1) {
      return Center(child: ProgressWidget());
    } else if(widget.showNeighborhood==2) {
      return Container(
        child: DropdownSerachWidget(
          items: widget.neighborhoodes??[],
          dropdownLabel: "Mahalle",
          onChange: (val){
            widget.result!.neighborhoodId=val.id;
            widget.onChange!(widget.result);
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
