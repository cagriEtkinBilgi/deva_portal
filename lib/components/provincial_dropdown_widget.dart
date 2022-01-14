import 'package:deva_portal/models/FakeData/adress.dart';
import 'package:deva_portal/models/addresses/provincial_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProvincialDropdown extends StatelessWidget {
  Function? onChange;

  ProvincialDropdown({this.onChange});

  Widget _customDropDownExample(
      BuildContext context, Provincial? item,) {
    return Container(
        child:
        (item?.CityName == null)
            ? ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text("İl Seçiniz",style: textStyle,),
        )
            :ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(item!.CityName??"",style: textStyle,),
        )
    );
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, Provincial item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(

        title: Text(item.CityName??"",style: textStyle,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Provincial>(

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
              borderSide: const BorderSide(
                  color: Colors.white
              )
          )
      ),*/
      dropdownSearchDecoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: textStyle,
          prefixIcon: const Icon(Icons.map,color: Colors.white)
      ),
      items: Adress.GetProvincial(),//DropDownDataları Getirilcek
      showSearchBox: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator:(val)=>FormValidations.ProvincialValidation(val),
      hint: "İl",
      //popupItemDisabled: (Provincial s) => s.ID==2,
      onChanged:(Provincial? d){
        onChange!(d!.ID);
      } ,
      popupTitle: const Center(child: const Padding(
        padding:EdgeInsets.all(8.0),
        child: const Text("İl Seç",style: TextStyle(
            color: Colors.white
        ),),
      )
      ),
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }
}

