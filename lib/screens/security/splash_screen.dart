import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  late SecurityViewModel _viewModel;
  bool send=true;
  @override
  Widget build(BuildContext context) {
    if(send){
      try{
        _viewModel=Provider.of<SecurityViewModel>(context);
         _viewModel.CurrentSesion().then((value){
          if(value=="1"){
            Navigator.of(context).pushReplacementNamed('/MainPage');
          }else{
            Navigator.of(context).pushReplacementNamed('/Login',arguments: {"message":value});
          }
        });
      }catch(e){
        Navigator.of(context).pushReplacementNamed('/Login',arguments: {"message":e.toString()});
      }
      send=false;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: gridBackgroundBox,
      child: const Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    );
  }
}
