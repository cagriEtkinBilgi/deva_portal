import 'package:deva_portal/tools/styles.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';

class NumberResetPage extends StatelessWidget {
  int ConfirmCode=0;
  var numberConfirmeKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: gridBackgroundBox,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 120,
            ),
            child: Form(
              key: numberConfirmeKey,
              child: Column(
                children: [
                  Text("Numara Doğrula",style: formTitleStyle,),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow:const [
                           BoxShadow(
                              color: Colors.black12
                          )
                        ]
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val)=>FormValidations.NumberConfirmeCodeValidation(val??""),
                      onChanged: (val){
                        ConfirmCode=int.parse(val);
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          labelText: "Doğrulam Kodu",
                          border: InputBorder.none,
                          labelStyle: textStyle,
                          hintText: "Doğrulam Kodu",
                          hintStyle: hintTextStyle,
                          prefixIcon: const Icon(Icons.vpn_key_sharp,color: Colors.white)
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){ debugPrint("Hop");},//Şifre Sıfırlama İşlemine gönderilecek
                      child: Text("Kod Ulaşmadı",style: textStyle,),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: (){
                        if(numberConfirmeKey.currentState!.validate()){
                          numberConfirmeKey.currentState!.save();
                          debugPrint(ConfirmCode.toString()); //Apiye Gönderilecek
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.white,
                      child: Text(
                        "Doğrula",
                        style: raiseButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
