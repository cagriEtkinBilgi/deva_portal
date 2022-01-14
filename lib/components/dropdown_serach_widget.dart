import 'package:deva_portal/models/component_models/dropdown_search_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSerachWidget extends StatelessWidget {

  List<DropdownSearchModel>? items;
  Function? onChange;
  int? selectedId;
  String? dropdownLabel;


  Widget _customDropDownExample(
      BuildContext context, DropdownSearchModel? item) {
    return Container(
        child:
        (item?.value == null)
            ? ListTile(
          contentPadding: EdgeInsets.all(0),
            title: Text(dropdownLabel??"",),
        )
            :ListTile(
          contentPadding: EdgeInsets.all(0),
            title: Text(item!.value??"",),
        )
    );
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, DropdownSearchModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(item.value??"",),
      ),
    );
  }

  DropdownSerachWidget({@required this.items,this.onChange,
    this.selectedId,this.dropdownLabel});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<DropdownSearchModel>(
      selectedItem: (selectedId!=null)?items!.firstWhere((e) => e.id==selectedId):null,
      mode: Mode.DIALOG,
      popupBackgroundColor: Colors.white,
      /*searchBoxDecoration: InputDecoration(
          border: OutlineInputBorder(
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
      ),
      items: items,//DropDownDataları Getirilcek
      showSearchBox: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator:(val)=>FormValidations.requaredDropdown(val),
      hint: dropdownLabel,
      //popupItemDisabled: (Provincial s) => s.ID==2,
      onChanged:(DropdownSearchModel? d){
        if(onChange!=null)
          onChange!(d);
      },
      popupTitle: Center(child: Padding(
        padding:EdgeInsets.all(8.0),
        child: Text(dropdownLabel??"",style: TextStyle(
            color: Colors.black
        ),
        ),
      )
      ),
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }
}
