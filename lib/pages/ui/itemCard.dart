import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Expanded(
       child: Container(
         margin: EdgeInsets.only(right: 5),
         decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(20)),
         padding: EdgeInsets.only(
             left: 10, right: 10, bottom: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               child: Image.asset("assets/banner1.png"),
             ),
             Container(
               margin: EdgeInsets.only(top: 10),
               child: Text(
                 "Producto 1",
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15),
               ),
             ),
             Container(
               margin: EdgeInsets.only(top: 5),
               child: Text(
                 "Esta es una descripcion del producto",
                 style: TextStyle(
                     color: Colors.grey, fontSize: 13),
               ),
             ),
             Container(
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     child: Text("\$8.000",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   ),
                   Container(
                     width: 60,
                     child: RaisedButton(
                       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                       color:Color(0xff08a791) ,
                       onPressed: (){

                       },
                       child: Icon(Icons.card_travel_sharp,color: Colors.white,),
                     ),
                   )
                 ],
               ),
             ),
             Container(
               child: null,
               height: 30,
             )
           ],
         ),
       ));
  }

}