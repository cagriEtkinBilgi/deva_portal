import 'package:deva_portal/models/FakeData/adress.dart';
import 'package:deva_portal/models/addresses/neighborhood_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class NeighborhoodDropdown extends StatelessWidget {
  int? DistrictID;
  Function? onChange;
  NeighborhoodDropdown({this.DistrictID, this.onChange});
  getData(){
    if(DistrictID!=null){
      return Adress.GetNeig();
    }
  }

  Widget _customDropDownExample(
      BuildContext context, Neighborhood? item) {
    return Container(
        child:
        (item?.NeighborhoodName == null)
            ? ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text("Mahalle Seçiniz",style: textStyle,),
        )
            :ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(item!.NeighborhoodName??"",style: textStyle,),
        )
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, Neighborhood item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color:Colors.white),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(item.NeighborhoodName??"",style: textStyle,),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Neighborhood>(
      mode: Mode.DIALOG,
      popupBackgroundColor: Colors.blue,
      /*searchBoxDecoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusColor: Colors.white,
          labelStyle: textStyle,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),*/
      dropdownSearchDecoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: textStyle,
          prefixIcon: const Icon(Icons.map,color: Colors.white)
      ),
      items: getData(),//DropDownDataları Getirilcek gelen ID
      showSearchBox: true,
      hint: "Mahalle",
      //popupItemDisabled: (Provincial s) => s.ID==2,
      onChanged:(Neighborhood? n){
        onChange!(n!.ID);
      },
      popupTitle: const Center(child: Padding(
        padding:EdgeInsets.all(8.0),
        child: Text("Mahalle Seç",style: TextStyle(
            color: Colors.white
        ),),
      )
      ),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator:(val)=>FormValidations.NeighborhoodValidation(val),
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }
}
