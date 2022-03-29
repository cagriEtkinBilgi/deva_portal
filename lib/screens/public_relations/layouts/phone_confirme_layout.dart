import 'package:deva_portal/components/radiobutons/timer_button_component.dart';
import 'package:deva_portal/tools/validations.dart';
import 'package:flutter/material.dart';

class PhoneConfirmeLayout extends StatelessWidget {

  Function? onChangeText;
  Function? onReSend;
  PhoneConfirmeLayout({
    Key? key,
    this.onReSend,
    this.onChangeText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TimerButtonComponent(
                    onPressed: onReSend!,
                  ),
                  Row(

                    children: const [
                       Icon(Icons.warning_amber_outlined,color: Colors.orangeAccent),
                       SizedBox(width: 15,),

                       Center(child: Text("Lütfen Telefon Numaranızı Doğrulayın",style: TextStyle(color:Colors.orangeAccent), ))
                    ],
                  ),
                  TextFormField(
                    validator: (val)=>FormValidations.NonEmty(val??""),
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      if(val!=""){
                        onChangeText!(val);
                      }
                    },
                    //initialValue:form.name,
                    decoration: const InputDecoration(
                      labelText: "Doğrulama Kodu",
                      hintText: "Doğrulama Kodu",
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
