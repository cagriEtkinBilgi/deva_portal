import 'package:deva_portal/models/component_models/custom_card_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCardWidget extends StatelessWidget {
  List<CustomCardDetailModel>? cards;
  CustomCardWidget({@required this.cards});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: createCardElement(),
      ),
    );
  }
  createCardElement(){
    List<Widget> generatedCards=[];
    for(var card in cards??[]){
      if(card.content!=""&&card.content!=null){
        generatedCards.add(Container(
          child: Container(
            color:card.cardColor??card.cardColor,
            child: ListTile(
              title: Text(card.title),
              subtitle: _launchURLButton(card.content,card.isLink),
              trailing: Icon(card.cardIcon),
            ),
          ),
        ));
      }
    }
    return generatedCards;
  }
  _launchURLButton(String url,bool isUrl){
    if(isUrl){
      return InkWell(
        onTap: (){
          _launchURL(url);
        },
        child: Text("Katıl",style: TextStyle(color: Colors.blue),),
      );
    }else{
      return Text(url);
    }

  }
  _launchURL (url) async  {    
    if (await canLaunch(url)) {
      await launch(url);
    } else {

    }
  }
}
