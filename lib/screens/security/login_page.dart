import 'package:deva_portal/components/message_dialog.dart';
import 'package:deva_portal/data/view_models/security_view_model.dart';
import 'package:deva_portal/enums/api_state.dart';
import 'package:deva_portal/models/security/login_model.dart';
import 'package:deva_portal/tools/styles.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  var loginFormKey=GlobalKey<FormState>();
  var loginModel=LoginModel();
  SecurityViewModel? _viewModel;
  String errorMessage="";
  LoginPage({dynamic args}){
    if(args!=null){
      if(args["message"]!=null)
        errorMessage=args["message"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _viewModel=Provider.of<SecurityViewModel>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gridBackgroundBox,
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 120,
            ),
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  Text(
                      "Giriş",
                    style: formTitleStyle,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: inputBoxDecoration,
                        child: TextFormField(
                          validator: (val)=>FormValidations.UserNameValidation(val??""),
                          onChanged: (val){
                            loginModel.UserName=val;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: "Kullanıcı Adı",
                              border: InputBorder.none,
                              labelStyle: textStyle,
                              hintText: "Kullanıcı Adı",
                              hintStyle: hintTextStyle,
                              prefixIcon: const Icon(Icons.person,color: Colors.white)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: inputBoxDecoration,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          validator: (val)=>FormValidations.PasswordValidation(val??""),
                          onChanged: (val){
                            loginModel.Password=val;
                          },
                          decoration: InputDecoration(
                              labelText: "Şifre",
                              border: InputBorder.none,
                              labelStyle: textStyle,
                              hintText: "Şifre Giriniz",
                              hintStyle: hintTextStyle,
                              prefixIcon: const Icon(Icons.vpn_key,color: Colors.white)
                          ),

                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){ debugPrint("Hop");},//Şifre Sıfırlama İşlemine gönderilecek
                          child: Text("Şifremi Unuttum!",style: textStyle,),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          onPressed: () async {
                            if(loginFormKey.currentState!.validate()){
                              loginFormKey.currentState!.save();
                              try{
                                await _viewModel!.Login(loginModel).then((value){
                                  if(value){
                                      Navigator.of(context).pushReplacementNamed('/MainPage');
                                  }else{
                                    CustomDialog.instance!.exceptionMessage(context,model: _viewModel!.errorModel!);
                                  }
                                });
                              }catch(e){
                                print(e);
                                CustomDialog.instance!.exceptionMessage(context,model: _viewModel!.errorModel!);
                              }
                            }
                          },
                          child: buttonText(_viewModel!.state!),
                        ),
                      ),
                      Container(
                        child: (errorMessage!="")?Text(errorMessage):Container(),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonText(ApiStateEnum state) {
    if(state==ApiStateEnum.initstate){
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }else if(state==ApiStateEnum.ErorState){
      //hata mesajı yazılacak
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }else if(state==ApiStateEnum.LodingState) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(backgroundColor: Colors.white,valueColor:AlwaysStoppedAnimation<Color>(Colors.blueAccent),),
      );
    }else{
      return Text(
        "Giriş",
        style: raiseButtonTextStyle,
      );
    }
  }
}
