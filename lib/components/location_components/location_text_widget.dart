import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationTextWidget extends StatefulWidget {
///İos için izinler alınacak https://pub.dev/packages/location
  Function? onChange;
  String? initVal;
  String? label;

  LocationTextWidget({this.initVal,this.onChange,this.label});

  @override
  _LocationTextWidgetState createState() => _LocationTextWidgetState();
}

class _LocationTextWidgetState extends State<LocationTextWidget> {
  late TextEditingController locationText;
  final _location= Location();
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  late bool _isServiceEnable;
  @override
  void initState(){
    locationText=TextEditingController(text: widget.initVal??"");
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: locationText,
            decoration: InputDecoration(
              labelText: widget.label??"Konum",
              hintText: widget.label??"Konum"
            ),
            onChanged: (val){
              widget.onChange!(val);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            child: const Icon(Icons.add_location),
            onPressed: () async {
              await _getLocation();
            },
          ),
        )
      ],
    );

  }
  _getLocation() async{
    _isServiceEnable=await _location.serviceEnabled();
    if(!_isServiceEnable){
      _isServiceEnable= await  _location.requestService();
      if(_isServiceEnable) return;
    }
    _permissionStatus=await _location.hasPermission();
    if(_permissionStatus==PermissionStatus.denied){
      _permissionStatus=await _location.requestPermission();
      if(_permissionStatus!= PermissionStatus.granted) return;
    }
    _locationData=await _location.getLocation();
  if(mounted){//kod önemli
    setState(() {
      var text="${_locationData.latitude} ${_locationData.longitude}";
      locationText.text=text;
      widget.onChange!(text);
    });
  }





  }
}
